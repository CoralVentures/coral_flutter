import 'package:coral_tester/coral_tester.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:routing_example/app/app_builder.dart';
import 'package:routing_example/blocs/analytic_listeners.dart';
import 'package:routing_example/blocs/counter/counter_bloc.dart';
import 'package:routing_example/pages/about/about_page.dart';
import 'package:routing_example/pages/home/home_page.dart';

void main() {
  coralTestGroup(
    'ABC-1',
    (userStoryId) {
      coralTestMockedApp<CoralMockedApp>(
        '''As a developer, I want to see an example of 'pushing' a route on the route stack, so that I can understand the difference between 'going' to a route''',
        userStoryId: userStoryId,
        screenshotDir: 'push_route',
        mockedApp: CoralMockedApp(appBuilder: appBuilder),
        analyticListeners: analyticListeners,
        test: (screenshot) async {
          await screenshot(
            description:
                '''Should start on the home page with a count of zero.''',
            expectations: (expect) async {
              expect(
                find.byType(Home_Page),
                findsOneWidget,
                reason: 'Should be on the home page',
              );
              expect(
                find.text('Count: 0'),
                findsOneWidget,
                reason: 'Count should be at 0',
              );
            },
            expectedEvents: [],
            expectedAnalytics: ['Screen: home'],
          );

          await screenshot(
            description: '''Should be able to change the Home Page's count''',
            actions: (userAction, testerAction) async {
              await userAction.tap(find.text('Increment'));
              await userAction.tap(find.text('Increment'));
              await testerAction.pumpAndSettle();
            },
            expectations: (expect) async {
              expect(
                find.text('Count: 2'),
                findsOneWidget,
                reason: 'Count should be at 2',
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

          await screenshot(
            description:
                '''If we 'push' to the about page, we should see the about page''',
            actions: (userAction, testerAction) async {
              await userAction.tap(
                find.text('Push to About Page'),
              );
              await testerAction.pumpAndSettle();
            },
            expectations: (expect) async {
              expect(
                find.byType(About_Page),
                findsOneWidget,
                reason: 'Should be on the about page',
              );
            },
            expectedEvents: [],
            expectedAnalytics: ['Screen: about'],
          );

          await screenshot(
            description:
                '''Since we pushed to the about page, we have a stack of pages (about page on top of home page). If we pop the about page off, and go back to the home page, the home page's count should be preserved.''',
            actions: (userAction, testerAction) async {
              await userAction.tap(
                find.byType(BackButton),
              );
              await testerAction.pumpAndSettle();
            },
            expectations: (expect) async {
              expect(
                find.byType(Home_Page),
                findsOneWidget,
                reason: 'Should be on the home page',
              );
              expect(
                find.text('Count: 2'),
                findsOneWidget,
                reason: 'Count should still be at 2',
              );
            },
            expectedEvents: [],
            expectedAnalytics: ['Screen: home'],
          );
        },
      );

      coralTestMockedApp<CoralMockedApp>(
        '''As a developer, I want to see an example of 'going' to a route, so that I can understand the difference between 'pushing' a route on a route stack''',
        userStoryId: userStoryId,
        screenshotDir: 'go_to_route',
        mockedApp: CoralMockedApp(appBuilder: appBuilder),
        analyticListeners: analyticListeners,
        test: (screenshot) async {
          await screenshot(
            description:
                '''Should start on the home page with a count of zero.''',
            expectations: (expect) async {
              expect(
                find.byType(Home_Page),
                findsOneWidget,
                reason: 'Should be on the home page',
              );
              expect(
                find.text('Count: 0'),
                findsOneWidget,
                reason: 'Count should be at 0',
              );
            },
            expectedEvents: [],
            expectedAnalytics: ['Screen: home'],
          );

          await screenshot(
            description: '''Should be able to change the Home Page's count''',
            actions: (userAction, testerAction) async {
              await userAction.tap(find.text('Decrement'));
              await userAction.tap(find.text('Decrement'));
              await testerAction.pumpAndSettle();
            },
            expectations: (expect) async {
              expect(
                find.text('Count: -2'),
                findsOneWidget,
                reason: 'Count should be at -2',
              );
            },
            expectedEvents: [
              CounterEvent_Decrement,
              CounterEvent_Decrement,
            ],
            expectedAnalytics: [
              'Track: Counter: Decrement',
              'Track: Counter: Decrement',
            ],
          );

          await screenshot(
            description:
                '''If we 'go' to the about page, we should see the about page''',
            actions: (userAction, testerAction) async {
              await userAction.tap(
                find.text('Go to About Page'),
              );
              await testerAction.pumpAndSettle();
            },
            expectations: (expect) async {
              expect(
                find.byType(About_Page),
                findsOneWidget,
                reason: 'Should be on the about page',
              );
            },
            expectedEvents: [],
            expectedAnalytics: ['Screen: about'],
          );

          await screenshot(
            description:
                '''Since we 'go'ed to the about page, we do not have a stack of pages, we only have the about page. The original home page does not exist. So if we go back to the home page, it will get recreated and the counter will be reset to 0.''',
            actions: (userAction, testerAction) async {
              await userAction.tap(
                find.text('Go to Home Page'),
              );
              await testerAction.pumpAndSettle();
            },
            expectations: (expect) async {
              expect(
                find.byType(Home_Page),
                findsOneWidget,
                reason: 'Should be on the home page',
              );
              expect(
                find.byType(BackButton),
                findsNothing,
                reason:
                    '''The back button should not exist, because there isn't a stack of routes.''',
              );
              expect(
                find.text('Count: 0'),
                findsOneWidget,
                reason: 'Count should not be -2, and should be reset to 0',
              );
            },
            expectedEvents: [],
            expectedAnalytics: ['Screen: home'],
          );
        },
      );
    },
  );
}
