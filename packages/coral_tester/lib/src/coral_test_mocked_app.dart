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
  required T? mockedApp,
  List<T>? mockedApps,
  required List<CoralBlocObserverAnalyticListener<dynamic>> analyticListeners,
  bool skip = false,
  bool printTesterLogs = true,
  bool printApplicationLogs = false,
  void Function(T mockedApp)? mocksBeforeTest,
  required Future<void> Function(CoralScreenshot<T>) test,
}) {
  assert(
    mockedApp != null && mockedApps == null ||
        mockedApp == null && mockedApps != null,
    'coral_tester: should use mockedApp or mockedApps, but not both',
  );

  final basePath = '${userStoryId.snakeCase}/$screenshotDir';

  testGoldens(
    description,
    (tester) async {
      // Ensure everything is initialized and ready to be tested.
      TestWidgetsFlutterBinding.ensureInitialized();

      // A user can pass in a single mockedApp or a list of mockedApps. We are
      // ensuring either option results in the same list.
      final _mockedApps = <T>[];
      if (mockedApp != null) {
        _mockedApps.add(mockedApp);
      }
      if (mockedApps != null) {
        _mockedApps.addAll(mockedApps);
      }

      // We will take a test 'trip' for every mockedApp in our list. We will do
      // certain things only on the first trip, so we need to keep track of
      // which trip we are on.
      var testerTripCount = 0;

      await Future.forEach(_mockedApps, (T _mockedApp) async {
        // Keep track if this is the first trip or not.
        final isFirstTrip = testerTripCount == 0;

        // Set up the bloc observer, which will keep track of analytic events
        // (without forwarding them to Segment).
        final blocObserver = CoralTestBlocObserver(
          mockAnalyticsRepository: _mockedApp.mockAnalyticsRepository,
          analyticListeners: analyticListeners,
        );
        Bloc.observer = blocObserver;
        blocObserver.mockAnalytics();

        // We can optionally print logs from our application.
        if (printApplicationLogs && isFirstTrip) {
          CoralLogger.addPrintClient();
        }
        putLumberdashToWork(
          withClients: [_mockedApp.mockLumberdashClient],
        );

        // The [coralTester] will keep track of our expectations, events,
        // analytics etc.
        final coralTester = CoralTester<T>(
          mockedApp: _mockedApp,
          blocObserver: blocObserver,
          widgetTester: tester,
          basePath: basePath,
          printTesterLogs: printTesterLogs && isFirstTrip,
          testerTripCount: testerTripCount,
          testerTotalTripCount: _mockedApps.length,
        );

        // The [descriptionRecord] is used by our gallery to let us know the big
        // picture of our test.
        final descriptionRecord = CoralTesterTestDescription(
          userStoryId: userStoryId,
          description: description,
        );

        // test logs are different from application logs. If test logs are
        // turned on, then we will print the description record first.
        if (printTesterLogs && isFirstTrip) {
          print(descriptionRecord);
        }

        // Since the [coralTester] keeps track of what we are doing, we will add
        // the [descriptionRecord].
        coralTester.testerRecords.add(descriptionRecord);

        ////////////////////
        // Testing sequence

        // 1) If there are mocks before we pump the app, then run them.
        if (mocksBeforeTest != null) {
          mocksBeforeTest.call(_mockedApp);
        }

        // 2) Since we will always be pumping the mockedApp to ensure all tests
        //    have the same starting point, we can do this for the developer.
        await coralTester.pumpApp();

        // 3) Finally, we can run the test and provide the developer with a
        //    utility to take screenshots. We are intentionally not giving
        //    direct access to the widgetTester to force developers to test in a
        //    screenshot driven way.
        await test(coralTester.screenshot);
        ////////////////////

        // If a) golden test are being updated and b) this is our first trip,
        // then we will create the following for the gallery:
        // - markdown file
        // - graphviz files
        if (autoUpdateGoldenFiles && isFirstTrip) {
          await tester.runAsync(
            () async {
              // Create markdown file
              //
              final markdownFile = await File('test/gallery/$basePath.md')
                  .create(recursive: true);
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
            },
          );
        }

        // Increment trip count
        testerTripCount++;
      });
    },
  );
}
