import 'package:bottom_nav_example/app/app_builder.dart';
import 'package:bottom_nav_example/blocs/analytic_listeners.dart';
import 'package:bottom_nav_example/blocs/bottom_nav/bottom_nav_bloc.dart';
import 'package:coral_tester/coral_tester.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  coralTestGroup('ABC-1', (userStoryId) {
    coralTestMockedApp(
      '''As a user, I should start on the home tab and be able to switch to the settings tab.''',
      userStoryId: userStoryId,
      screenshotDir: 'tabs',
      mockedApp: CoralMockedApp(appBuilder: appBuilder),
      analyticListeners: analyticListeners,
      test: (tester) async {
        await tester.pumpApp();

        await tester.screenshot(
          comment: 'Should start on the home tab',
          runExpectations: () {
            tester
              ..expect(
                find.byWidgetPredicate((widget) {
                  if (widget is AppBar) {
                    if (widget.title is Text) {
                      final widgetText = widget.title as Text?;

                      return widgetText?.data == 'Home';
                    }
                  }

                  return false;
                }),
                findsOneWidget,
                reason: 'Should see the Home app bar',
              )
              ..expect(
                find.byWidgetPredicate((widget) {
                  if (widget is BottomNavigationBar) {
                    return widget.currentIndex == 0;
                  }
                  return false;
                }),
                findsOneWidget,
                reason: 'Bottom navigation index should be 0',
              );
          },
          expectedEvents: [BottomNavEvent_ToHome],
          expectedAnalytics: ['Screen: /:screen(home|settings)'],
        );

        await tester.screenshot(
          comment: 'Should be able to go to the settings tab',
          takeActions: () async {
            await tester.tap(
              find.byIcon(Icons.settings),
              pumpAndSettle: true,
            );
          },
          runExpectations: () {
            tester
              ..expect(
                find.byWidgetPredicate((widget) {
                  if (widget is AppBar) {
                    if (widget.title is Text) {
                      final widgetText = widget.title as Text?;

                      return widgetText?.data == 'Settings';
                    }
                  }

                  return false;
                }),
                findsOneWidget,
                reason: 'Should see the Settings app bar',
              )
              ..expect(
                find.byWidgetPredicate((widget) {
                  if (widget is BottomNavigationBar) {
                    return widget.currentIndex == 1;
                  }
                  return false;
                }),
                findsOneWidget,
                reason: 'Bottom navigation index should be 1',
              );
          },
          expectedEvents: [BottomNavEvent_ToSettings],
          expectedAnalytics: [],
        );

        await tester.screenshot(
          comment: 'Should be able to go back to the home tab',
          takeActions: () async {
            await tester.tap(find.byIcon(Icons.home), pumpAndSettle: true);
          },
          runExpectations: () {
            tester
              ..expect(
                find.byWidgetPredicate((widget) {
                  if (widget is AppBar) {
                    if (widget.title is Text) {
                      final widgetText = widget.title as Text?;

                      return widgetText?.data == 'Home';
                    }
                  }

                  return false;
                }),
                findsOneWidget,
                reason: 'Should see the Home app bar',
              )
              ..expect(
                find.byWidgetPredicate((widget) {
                  if (widget is BottomNavigationBar) {
                    return widget.currentIndex == 0;
                  }
                  return false;
                }),
                findsOneWidget,
                reason: 'Bottom navigation index should be 0',
              );
          },
          expectedEvents: [BottomNavEvent_ToHome],
          expectedAnalytics: [],
        );
      },
    );
  });
}
