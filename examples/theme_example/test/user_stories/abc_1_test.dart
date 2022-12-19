import 'package:coral_tester/coral_tester.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theme_example/app/app_builder.dart';
import 'package:theme_example/app/app_theme.dart';
import 'package:theme_example/blocs/analytic_listeners.dart';
import 'package:theme_example/blocs/counter/counter_bloc.dart';

void main() {
  coralTestGroup('ABC-1', (userStoryId) {
    final mockedApps = <CoralMockedApp>[
      CoralMockedApp(
        appBuilder: ({analyticsRepository}) => appBuilder(
          key: const Key('light'),
          analyticsRepository: analyticsRepository,
          themeMode: ThemeMode.light,
          coralThemeDataLight: appThemeDataLight,
          coralThemeDataDark: appThemeDataDark,
        ),
      ),
      CoralMockedApp(
        appBuilder: ({analyticsRepository}) => appBuilder(
          key: const Key('dark'),
          analyticsRepository: analyticsRepository,
          themeMode: ThemeMode.dark,
          coralThemeDataLight: appThemeDataLight,
          coralThemeDataDark: appThemeDataDark,
        ),
      ),
    ];
    coralTestMockedApp<CoralMockedApp>(
      '''As a user, I should be able to change the count, so that I can keep count of things.''',
      userStoryId: userStoryId,
      mockedApp: null,
      mockedApps: mockedApps,
      analyticListeners: analyticListeners,
      screenshotDir: 'change_count',
      test: (screenshot) async {
        await screenshot(
          expectations: (exepect) {
            expect(
              find.text('Count: 0'),
              findsOneWidget,
              reason: 'Should see initial count of zero',
            );
          },
          expectedAnalytics: ['Screen: Home'],
        );

        await screenshot(
          description: 'As a user, I want to be able to decrement the count',
          actions: (userAction, testerAction) async {
            await userAction.tap(find.text('Decrement'));
            await testerAction.pumpAndSettle();
          },
          expectations: (expect) {
            expect(
              find.text('Count: -1'),
              findsOneWidget,
              reason: 'Should see count decremented by one',
            );
          },
          expectedEvents: [
            CounterEvent_Decrement,
          ],
          expectedAnalytics: [
            'Track: Counter: Decrement',
          ],
        );

        await screenshot(
          description: 'As a user, I want to be able to increment the count',
          actions: (userAction, testerAction) async {
            await userAction.tap(find.text('Increment'));
            await userAction.tap(find.text('Increment'));
            await testerAction.pumpAndSettle();
          },
          expectations: (expect) {
            expect(
              find.text('Count: 1'),
              findsOneWidget,
              reason: 'Should see count incremented by two',
            );
          },
          expectedEvents: [
            CounterEvent_Increment,
            CounterEvent_Increment,
          ],
          expectedAnalytics: [
            'Track: Counter: Increment',
            'Track: Counter: Increment',
          ],
        );
      },
    );
  });
}