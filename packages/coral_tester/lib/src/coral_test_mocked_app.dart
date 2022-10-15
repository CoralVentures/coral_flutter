// ignore_for_file: avoid_print

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:coral_tester/coral_tester.dart';
import 'package:coral_tester/src/coral_test_bloc_observer.dart';
import 'package:coral_tester/src/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:meta/meta.dart';

/// This [coralTestMockedApp] method runs [testGoldens] with a [CoralMockedApp]
/// and sets the Bloc.observer to a [CoralTestBlocObserver].
///
/// - [description] is a test description
/// - [basePath] is used to namespace the golden images in a specific folder
/// - [skip] to skip the test
/// - [test] is the test body
///
@isTestGroup
void coralTestMockedApp<T extends CoralMockedApp>(
  String description, {
  required String basePath,
  required T mockedApp,
  required List<CoralBlocObserverAnalyticListener<dynamic>> analyticListeners,
  bool skip = false,
  required Future<void> Function(CoralTester<T> tester) test,
}) {
  testGoldens(
    description,
    (tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();

      final blocObserver = CoralTestBlocObserver(
        mockAnalyticsRepository: mockedApp.mockAnalyticsRepository,
        analyticListeners: analyticListeners,
      );

      Bloc.observer = blocObserver;

      blocObserver.mockAnalytics();
      putLumberdashToWork(
        withClients: [
          mockedApp.mockLumberdashClient,
          // PrintLumberdash(),
        ],
      );

      final coralTester = CoralTester<T>(
        mockedApp: mockedApp,
        blocObserver: blocObserver,
        tester: tester,
        basePath: basePath,
      );

      final descriptionRecord =
          CoralTesterTestDescription(description: description);
      print(descriptionRecord);
      coralTester.testerRecords.add(descriptionRecord);

      await test(coralTester);

      await tester.runAsync(() async {
        // Create markdown file
        //
        final markdownFile =
            await File('test/gallery/$basePath.md').create(recursive: true);
        final markdownSink = markdownFile.openWrite();

        for (final element in coralTester.testerRecords) {
          markdownSink.write(element.toMarkdown());
        }
        await markdownSink.close();

        // Create graphviz files
        //
        final checkpoints =
            coralTester.testerRecords.whereType<CoralTesterCheckpoint>();

        for (final checkpoint in checkpoints) {
          final graphvizFilePath =
              'test/gallery/${checkpoint.screenshotPath}.dot';
          final graphvizFile =
              await File(graphvizFilePath).create(recursive: true);
          final graphvizSink = graphvizFile.openWrite();

          // ignore: cascade_invocations
          graphvizSink.write(checkpoint.toGraphviz());

          await graphvizSink.close();

          await Process.run(
            'dot',
            [
              graphvizFilePath,
              '-Tpng',
              '-Gdpi=400',
              '-o',
              'test/gallery/${checkpoint.screenshotPath}.png',
            ],
          );
        }
      });
    },
  );
}
