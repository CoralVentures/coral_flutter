// ignore_for_file: avoid_print

import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:coral_logger/coral_logger.dart';
import 'package:coral_tester/coral_tester.dart';
import 'package:coral_tester/src/coral_test_bloc_observer.dart';
import 'package:coral_tester/src/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:meta/meta.dart';
import 'package:recase/recase.dart';

@isTestGroup
void coralTestGroup(
  String userStoryId,
  void Function(String userStoryId) body, {
  bool skip = false,
}) {
  group(
    userStoryId,
    () => body(userStoryId),
    skip: skip,
  );
}

/// This [coralTestMockedApp] method runs [testGoldens] with a [CoralMockedApp]
/// and sets the Bloc.observer to a [CoralTestBlocObserver]. In addition, if
/// golden images are being created, then markdown and graphviz files will be
/// created for the gallery.
///
/// - [description] is a test description
/// - [screenshotDir] is used to namespace the golden images into a specific
///   directory
/// - [skip] to skip the test
/// - [mocksBeforeTest] to add mocks before the test runs
/// - [test] is the test body
/// - [printTesterLogs] will print tester logs, defaults to true
/// - [printApplicationLogs] will print application logs, defaults to false
///
@isTest
void coralTestMockedApp<T extends CoralMockedApp>(
  String description, {
  required String userStoryId,
  required String screenshotDir,
  required T mockedApp,
  required List<CoralBlocObserverAnalyticListener<dynamic>> analyticListeners,
  bool skip = false,
  bool printTesterLogs = true,
  bool printApplicationLogs = false,
  void Function(T mockedApp)? mocksBeforeTest,
  required Future<void> Function(CoralScreenshot<T>) test,
}) {
  final basePath = '${userStoryId.snakeCase}/$screenshotDir';

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

      if (printApplicationLogs) {
        CoralLogger.addPrintClient();
      }
      putLumberdashToWork(
        withClients: [mockedApp.mockLumberdashClient],
      );

      final coralTester = CoralTester<T>(
        mockedApp: mockedApp,
        blocObserver: blocObserver,
        widgetTester: tester,
        basePath: basePath,
        printTesterLogs: printTesterLogs,
      );

      final descriptionRecord = CoralTesterTestDescription(
        userStoryId: userStoryId,
        description: description,
      );

      if (printTesterLogs) {
        print(descriptionRecord);
      }

      coralTester.testerRecords.add(descriptionRecord);

      if (mocksBeforeTest != null) {
        mocksBeforeTest.call(mockedApp);
      }

      await coralTester.pumpApp();
      await test(coralTester.screenshot);

      /// If running Golden tests, then also generate markdown and graphvz files
      if (autoUpdateGoldenFiles) {
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
                '-Gdpi=300',
                '-o',
                'test/gallery/${checkpoint.screenshotPath}.png',
              ],
            );
          }
        });
      }
    },
  );
}
