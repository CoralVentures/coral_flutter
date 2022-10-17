// ignore_for_file: avoid_print

import 'package:coral_tester/coral_tester.dart';
import 'package:coral_tester/src/coral_test_bloc_observer.dart';
import 'package:coral_tester/src/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart' as ft;
import 'package:golden_toolkit/golden_toolkit.dart';

class CoralTester<T extends CoralMockedApp> {
  CoralTester({
    required this.mockedApp,
    required this.blocObserver,
    required this.widgetTester,
    required this.basePath,
    required this.printTesterLogs,
  });

  final T mockedApp;
  final CoralTestBlocObserver blocObserver;
  final ft.WidgetTester widgetTester;
  final String basePath;
  final bool printTesterLogs;

  final List<CoralTesterRecord> testerRecords = [];
  final List<CoralTesterAction> testerActions = [];
  final List<String> expectationReasons = [];

  //
  // Expectations
  //

  void expectEventsInOrder(List<Type> events, {String? reason}) {
    ft.expect(blocObserver.events, events, reason: reason);
    _clearTrackedEvents();
  }

  void expectAnalyticsInOrder(List<String> analytics, {String? reason}) {
    ft.expect(blocObserver.analytics, analytics, reason: reason);
    _clearTrackedAnalytics();
  }

  void clearTrackedEventsAndAnalytics() {
    _clearTrackedEvents();
    _clearTrackedAnalytics();
  }

  void _clearTrackedEvents() {
    blocObserver.events.clear();
  }

  void _clearTrackedAnalytics() {
    blocObserver.analytics.clear();
  }

  void expect(
    dynamic actual,
    dynamic matcher, {
    required String reason,
    dynamic skip,
  }) {
    expectationReasons.add(reason);
    ft.expect(
      actual,
      matcher,
      reason: reason,
      skip: skip,
    );
  }

  //
  // Screenshot
  //

  int _screenshotCounter = 0;

  Future<void> screenshot({
    String? comment,
    AsyncCallback? takeActions,
    VoidCallback? runExpectations,
    List<Type> expectedEvents = const [],
    List<String> expectedAnalytics = const [],
  }) async {
    if (takeActions != null) {
      await takeActions.call();
    }

    /// Get unique prefix
    final resolvedCounter = _screenshotCounter.toRadixString(36);
    _screenshotCounter++;

    String? screenName;
    try {
      screenName = blocObserver.analytics
          .lastWhere((element) => element.contains('Screen: '))
          .replaceAll('Screen: ', '');
    } catch (_) {}

    if (screenName != null) {
      final screenRecord = CoralTesterScreen(screenName: screenName);
      if (printTesterLogs) {
        print(screenRecord);
      }
      testerRecords.add(screenRecord);
    }

    final screenshotPath = '$basePath/$resolvedCounter';

    /// Check expectations
    runExpectations?.call();

    /// Save checkpoint
    final checkpoint = CoralTesterCheckpoint(
      screenshotPath: screenshotPath,
      actions: List.from(testerActions),
      expectationReasons: List.from(expectationReasons),
      events: List.from(blocObserver.events),
      analytics: List.from(blocObserver.analytics),
      comment: comment,
    );

    if (printTesterLogs) {
      print(checkpoint);
    }
    testerRecords.add(checkpoint);

    /// Take Screenshot
    await multiScreenGolden(
      widgetTester,
      screenshotPath,
      devices: goldenDevices,
    );

    /// Check events and analytics, then clean up all tracked items
    expectEventsInOrder(expectedEvents);
    expectAnalyticsInOrder(expectedAnalytics);
    testerActions.clear();
    expectationReasons.clear();
  }

  //
  // Tester Actions
  //

  Future<void> pumpApp() async {
    await widgetTester.pumpWidget(await mockedApp.createApp());
    await widgetTester.pumpAndSettle();
  }

  Future<void> tap(
    ft.Finder finder, {
    bool? pumpAndSettle,
  }) async {
    testerActions.add(
      CoralTesterAction(
        action: CoralTesterActions.tap,
        finderDescription: finder.description,
      ),
    );
    await widgetTester.tap(finder);
    if (pumpAndSettle != null && pumpAndSettle) {
      await widgetTester.pumpAndSettle();
    } else {
      await widgetTester.pump();
    }
  }
}
