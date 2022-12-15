// ignore_for_file: avoid_print

import 'package:coral_tester/coral_tester.dart';
import 'package:coral_tester/src/coral_test_bloc_observer.dart';
import 'package:coral_tester/src/models.dart';
import 'package:flutter_test/flutter_test.dart' as ft;
import 'package:golden_toolkit/golden_toolkit.dart';

typedef CoralExpect = void Function(
  dynamic actual,
  dynamic matcher, {
  required String reason,
  dynamic skip,
});

typedef CoralTakeActions = Future<void> Function(
  CoralTesterUserActions userAction,
  ft.WidgetTester testerAction,
);

typedef CoralScreenshot<T> = Future<void> Function({
  String? description,
  void Function(T mockedApp)? mocks,
  CoralTakeActions? actions,
  void Function(CoralExpect expect)? expectations,
  List<Type> expectedEvents,
  List<String> expectedAnalytics,
});

class CoralTester<T extends CoralMockedApp> {
  CoralTester({
    required this.mockedApp,
    required this.blocObserver,
    required ft.WidgetTester widgetTester,
    required this.basePath,
    required this.printTesterLogs,
    required this.testerTripCount,
    required this.testerTotalTripCount,
  }) : _widgetTester = widgetTester;

  final T mockedApp;
  final CoralTestBlocObserver blocObserver;
  final ft.WidgetTester _widgetTester;
  final String basePath;
  final bool printTesterLogs;
  final int testerTripCount;
  final int testerTotalTripCount;

  final List<CoralTesterRecord> testerRecords = [];
  final List<CoralTesterAction> testerActions = [];
  final List<String> expectationReasons = [];

  late CoralTesterUserActions userAction = CoralTesterUserActions(
    widgetTester: _widgetTester,
    testerActions: testerActions,
  );

  late ft.WidgetTester testerAction = _widgetTester;

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
    String? description,
    void Function(T mockedApp)? mocks,
    CoralTakeActions? actions,
    void Function(CoralExpect expect)? expectations,
    List<Type> expectedEvents = const [],
    List<String> expectedAnalytics = const [],
  }) async {
    if (mocks != null) {
      mocks.call(mockedApp);
    }

    if (actions != null) {
      await actions.call(
        userAction,
        testerAction,
      );
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

    /// Take Screenshot
    await multiScreenGolden(
      _widgetTester,
      '$screenshotPath.$testerTripCount',
      devices: goldenDevices,
    );

    /// Check expectations
    if (expectations != null) {
      expectations.call(expect);
    }

    /// Save checkpoint
    final checkpoint = CoralTesterCheckpoint(
      screenshotPath: screenshotPath,
      actions: List.from(testerActions),
      expectationReasons: List.from(expectationReasons),
      events: List.from(blocObserver.events),
      analytics: List.from(blocObserver.analytics),
      description: description,
      testerTotalTripCount: testerTotalTripCount,
    );

    if (printTesterLogs) {
      print(checkpoint);
    }
    testerRecords.add(checkpoint);

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
    await _widgetTester.pumpWidget(await mockedApp.createApp());
    await _widgetTester.pumpAndSettle();
  }
}
