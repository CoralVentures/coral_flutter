// ignore_for_file: avoid_print

import 'package:coral_tester/coral_tester.dart';
import 'package:coral_tester/src/coral_test_bloc_observer.dart';
import 'package:coral_tester/src/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart' as ft;
import 'package:golden_toolkit/golden_toolkit.dart';

class CoralTester<T extends CoralMockedApp> {
  CoralTester({
    required this.mockedApp,
    required this.blocObserver,
    required ft.WidgetTester widgetTester,
    required this.basePath,
    required this.printTesterLogs,
  }) : _widgetTester = widgetTester;

  final T mockedApp;
  final CoralTestBlocObserver blocObserver;
  final ft.WidgetTester _widgetTester;
  final String basePath;
  final bool printTesterLogs;

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
    String? comment,
    void Function(T mockedApp)? mockRepositories,
    AsyncCallback? takeActions,
    VoidCallback? runExpectations,
    List<Type> expectedEvents = const [],
    List<String> expectedAnalytics = const [],
  }) async {
    if (mockRepositories != null) {
      mockRepositories.call(mockedApp);
    }

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
      _widgetTester,
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
    await _widgetTester.pumpWidget(await mockedApp.createApp());
    await _widgetTester.pumpAndSettle();
  }
}

class CoralTesterUserActions {
  CoralTesterUserActions({
    required ft.WidgetTester widgetTester,
    required List<CoralTesterAction> testerActions,
  })  : _widgetTester = widgetTester,
        _testerActions = testerActions;

  final ft.WidgetTester _widgetTester;
  final List<CoralTesterAction> _testerActions;

  Future<void> drag(
    ft.Finder finder,
    Offset offset, {
    int? pointer,
    int buttons = kPrimaryButton,
    double touchSlopX = ft.kDragSlopDefault,
    double touchSlopY = ft.kDragSlopDefault,
    bool warnIfMissed = true,
    PointerDeviceKind kind = PointerDeviceKind.touch,
  }) async {
    _testerActions.add(
      CoralTesterAction(
        description:
            '''Dragged: ${finder.description} by (x: ${offset.dx}, y: ${offset.dy})''',
      ),
    );
    await _widgetTester.drag(
      finder,
      offset,
      pointer: pointer,
      buttons: buttons,
      touchSlopX: touchSlopX,
      touchSlopY: touchSlopY,
      kind: kind,
    );
  }

  Future<void> dragFrom(
    Offset startLocation,
    Offset offset, {
    int? pointer,
    int buttons = kPrimaryButton,
    double touchSlopX = ft.kDragSlopDefault,
    double touchSlopY = ft.kDragSlopDefault,
    bool warnIfMissed = true,
    PointerDeviceKind kind = PointerDeviceKind.touch,
  }) async {
    _testerActions.add(
      CoralTesterAction(
        description:
            '''Dragged from: (x: ${startLocation.dx}, y: ${startLocation.dy}) by (x: ${offset.dx}, y: ${offset.dy})''',
      ),
    );
    await _widgetTester.dragFrom(
      startLocation,
      offset,
      pointer: pointer,
      buttons: buttons,
      touchSlopX: touchSlopX,
      touchSlopY: touchSlopY,
      kind: kind,
    );
  }

  Future<void> dragUntilVisible(
    ft.Finder finder,
    ft.Finder view,
    Offset moveStep, {
    int maxIteration = 50,
    Duration duration = const Duration(milliseconds: 50),
  }) async {
    _testerActions.add(
      CoralTesterAction(
        description:
            '''Dragged until visible: ${finder.description} -> ${view.description}''',
      ),
    );
    await _widgetTester.dragUntilVisible(
      finder,
      view,
      moveStep,
      maxIteration: maxIteration,
      duration: duration,
    );
  }

  Future<void> enterText(
    ft.Finder finder,
    String text,
  ) async {
    _testerActions.add(
      CoralTesterAction(
        description: '''Entered Text''',
      ),
    );
    await _widgetTester.enterText(
      finder,
      text,
    );
  }

  Future<void> fling(
    ft.Finder finder,
    Offset offset,
    double speed, {
    int? pointer,
    int buttons = kPrimaryButton,
    Duration frameInterval = const Duration(milliseconds: 16),
    Offset initialOffset = Offset.zero,
    Duration initialOffsetDelay = const Duration(seconds: 1),
    bool warnIfMissed = true,
  }) async {
    _testerActions.add(
      CoralTesterAction(
        description:
            '''Flinged: ${finder.description} by (x: ${offset.dx}, y: ${offset.dy})''',
      ),
    );
    await _widgetTester.fling(
      finder,
      offset,
      speed,
      pointer: pointer,
      buttons: buttons,
      frameInterval: frameInterval,
      initialOffset: initialOffset,
      initialOffsetDelay: initialOffsetDelay,
      warnIfMissed: warnIfMissed,
    );
  }

  Future<void> flingFrom(
    Offset startLocation,
    Offset offset,
    double speed, {
    int? pointer,
    int buttons = kPrimaryButton,
    Duration frameInterval = const Duration(milliseconds: 16),
    Offset initialOffset = Offset.zero,
    Duration initialOffsetDelay = const Duration(seconds: 1),
    bool warnIfMissed = true,
  }) async {
    _testerActions.add(
      CoralTesterAction(
        description:
            '''Flinged from: (x: ${startLocation.dx}, y: ${startLocation.dy}) by (x: ${offset.dx}, y: ${offset.dy})''',
      ),
    );
    await _widgetTester.flingFrom(
      startLocation,
      offset,
      speed,
      pointer: pointer,
      buttons: buttons,
      frameInterval: frameInterval,
      initialOffset: initialOffset,
      initialOffsetDelay: initialOffsetDelay,
    );
  }

  Future<void> longPress(
    ft.Finder finder, {
    int? pointer,
    int buttons = kPrimaryButton,
    bool warnIfMissed = true,
  }) async {
    _testerActions.add(
      CoralTesterAction(
        description: '''Long pressed: ${finder.description}''',
      ),
    );
    await _widgetTester.longPress(
      finder,
      pointer: pointer,
      buttons: buttons,
      warnIfMissed: warnIfMissed,
    );
  }

  Future<void> longPressAt(
    Offset location, {
    int? pointer,
    int buttons = kPrimaryButton,
    bool warnIfMissed = true,
  }) async {
    _testerActions.add(
      CoralTesterAction(
        description:
            '''Long pressed at: (x: ${location.dx}, y: ${location.dy})''',
      ),
    );
    await _widgetTester.longPressAt(
      location,
      pointer: pointer,
      buttons: buttons,
    );
  }

  Future<void> pageBack(
    ft.Finder finder, {
    int? pointer,
    int buttons = kPrimaryButton,
    bool warnIfMissed = true,
  }) async {
    _testerActions.add(
      CoralTesterAction(
        description: '''Paged back''',
      ),
    );
    await _widgetTester.pageBack();
  }

  Future<void> press(
    ft.Finder finder, {
    int? pointer,
    int buttons = kPrimaryButton,
    bool warnIfMissed = true,
  }) async {
    _testerActions.add(
      CoralTesterAction(
        description: '''Pressed: ${finder.description}''',
      ),
    );
    await _widgetTester.press(
      finder,
      pointer: pointer,
      buttons: buttons,
      warnIfMissed: warnIfMissed,
    );
  }

  Future<void> scrollUntilVisible(
    ft.Finder finder,
    double delta, {
    ft.Finder? scrollable,
    int maxScrolls = 50,
    Duration duration = const Duration(milliseconds: 50),
  }) async {
    _testerActions.add(
      CoralTesterAction(
        description: '''Scrolled until visible: ${finder.description}''',
      ),
    );
    await _widgetTester.scrollUntilVisible(
      finder,
      delta,
      scrollable: scrollable,
      maxScrolls: maxScrolls,
      duration: duration,
    );
  }

  static const String _defaultPlatform = kIsWeb ? 'web' : 'android';
  Future<void> sendKeydownEvent(
    LogicalKeyboardKey key, {
    String platform = _defaultPlatform,
    String? character,
    PhysicalKeyboardKey? physicalKey,
  }) async {
    _testerActions.add(
      CoralTesterAction(
        description: '''Sent key down event: ${key.debugName}''',
      ),
    );
    await _widgetTester.sendKeyDownEvent(
      key,
      platform: platform,
      character: character,
      physicalKey: physicalKey,
    );
  }

  Future<void> sendKeyEvent(
    LogicalKeyboardKey key, {
    String platform = _defaultPlatform,
    String? character,
    PhysicalKeyboardKey? physicalKey,
  }) async {
    _testerActions.add(
      CoralTesterAction(
        description: '''Sent key event: ${key.debugName}''',
      ),
    );
    await _widgetTester.sendKeyEvent(
      key,
      platform: platform,
      character: character,
      physicalKey: physicalKey,
    );
  }

  Future<void> sendKeyRepeatEvent(
    LogicalKeyboardKey key, {
    String platform = _defaultPlatform,
    String? character,
    PhysicalKeyboardKey? physicalKey,
  }) async {
    _testerActions.add(
      CoralTesterAction(
        description: '''Sent key repeat event: ${key.debugName}''',
      ),
    );
    await _widgetTester.sendKeyRepeatEvent(
      key,
      platform: platform,
      character: character,
      physicalKey: physicalKey,
    );
  }

  Future<void> sendKeyUpEvent(
    LogicalKeyboardKey key, {
    String platform = _defaultPlatform,
    String? character,
    PhysicalKeyboardKey? physicalKey,
  }) async {
    _testerActions.add(
      CoralTesterAction(
        description: '''Sent key up event: ${key.debugName}''',
      ),
    );
    await _widgetTester.sendKeyUpEvent(
      key,
      platform: platform,
      physicalKey: physicalKey,
    );
  }

  Future<void> startGesture(
    Offset downLocation, {
    int? pointer,
    PointerDeviceKind kind = PointerDeviceKind.touch,
    int buttons = kPrimaryButton,
  }) async {
    _testerActions.add(
      CoralTesterAction(
        description:
            '''Started gesture: (x: ${downLocation.dx} y: ${downLocation.dy})''',
      ),
    );
    await _widgetTester.startGesture(
      downLocation,
      pointer: pointer,
      kind: kind,
      buttons: buttons,
    );
  }

  Future<void> tap(
    ft.Finder finder, {
    int? pointer,
    int buttons = kPrimaryButton,
    bool warnIfMissed = true,
  }) async {
    _testerActions.add(
      CoralTesterAction(
        description: 'Tapped: ${finder.description}',
      ),
    );
    await _widgetTester.tap(
      finder,
      pointer: pointer,
      buttons: buttons,
      warnIfMissed: warnIfMissed,
    );
  }

  Future<void> tapAt(
    Offset location, {
    int? pointer,
    int buttons = kPrimaryButton,
    bool warnIfMissed = true,
  }) async {
    _testerActions.add(
      CoralTesterAction(
        description: 'Tapped at: (x: ${location.dx}, y: ${location.dy})',
      ),
    );
    await _widgetTester.tapAt(
      location,
      pointer: pointer,
      buttons: buttons,
    );
  }

  Future<void> timedDrag(
    ft.Finder finder,
    Offset offset,
    Duration duration, {
    int? pointer,
    int buttons = kPrimaryButton,
    double frequency = 60.0,
    bool warnIfMissed = true,
  }) async {
    _testerActions.add(
      CoralTesterAction(
        description:
            '''Timed drag: ${finder.description} by (x: ${offset.dx}, y: ${offset.dy})''',
      ),
    );
    await _widgetTester.timedDrag(
      finder,
      offset,
      duration,
      pointer: pointer,
      buttons: buttons,
      frequency: frequency,
      warnIfMissed: warnIfMissed,
    );
  }

  Future<void> timedDragFrom(
    Offset startLocation,
    Offset offset,
    Duration duration, {
    int? pointer,
    int buttons = kPrimaryButton,
    double frequency = 60.0,
  }) async {
    _testerActions.add(
      CoralTesterAction(
        description:
            '''Timed drag from: (x: ${startLocation.dx}, y: ${startLocation.dy}) by (x: ${offset.dx}, y: ${offset.dy})''',
      ),
    );
    await _widgetTester.timedDragFrom(
      startLocation,
      offset,
      duration,
      pointer: pointer,
      buttons: buttons,
      frequency: frequency,
    );
  }
}
