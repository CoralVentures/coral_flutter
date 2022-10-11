// ignore_for_file: avoid_print

import 'package:coral_tester/coral_tester.dart';
import 'package:coral_tester/src/coral_mocked_app.dart';
import 'package:coral_tester/src/coral_test_bloc_observer.dart';
import 'package:coral_tester/src/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

class CoralTester {
  CoralTester({
    required this.mockedApp,
    required this.blocObserver,
    required this.tester,
    required this.basePath,
  });

  final CoralMockedApp mockedApp;
  final CoralTestBlocObserver blocObserver;
  final WidgetTester tester;
  final String basePath;

  final List<CoralTesterRecord> testerRecords = [];
  final List<CoralTesterAction> testerActions = [];
  final List<String> expectationReasons = [];

  //
  // Expectations
  //

  void expectEventsInOrder(List<Type> events, {String? reason}) {
    expect(blocObserver.events, events, reason: reason);
    _clearTrackedEvents();
  }

  void expectAnalyticsInOrder(List<String> analytics, {String? reason}) {
    expect(blocObserver.analytics, analytics, reason: reason);
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

  void expectWithReason(
    dynamic actual,
    dynamic matcher, {
    required String reason,
    dynamic skip,
  }) {
    expectationReasons.add(reason);
    expect(
      actual,
      matcher,
      reason: reason,
      skip: skip,
    );
  }

  //
  // Screenshot
  //

  int screenshotCounter = 0;

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
    final resolvedCounter = screenshotCounter.toRadixString(36);
    screenshotCounter++;

    String? screenName;
    try {
      screenName = blocObserver.analytics
          .lastWhere((element) => element.contains('Screen: '))
          .replaceAll('Screen: ', '');
    } catch (_) {}

    if (screenName != null) {
      final screenRecord = CoralTesterScreen(screenName: screenName);
      print(screenRecord);
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

    print(checkpoint);
    testerRecords.add(checkpoint);

    /// Take Screenshot
    await multiScreenGolden(
      tester,
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
    await tester.pumpWidget(await mockedApp.createApp());
  }

  Future<void> tap(
    Finder finder, {
    bool? pumpAndSettle,
  }) async {
    testerActions.add(
      CoralTesterAction(
        action: CoralTesterActions.tap,
        finderDescription: finder.description,
      ),
    );
    await tester.tap(finder);
    if (pumpAndSettle != null && pumpAndSettle) {
      await tester.pumpAndSettle();
    } else {
      await tester.pump();
    }
  }
}
