import 'package:coral_tester/coral_tester.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:routing_example/app/builder.dart';
import 'package:routing_example/blocs/analytic_listeners.dart';
import 'package:routing_example/blocs/app/bloc.dart';
import 'package:routing_example/blocs/counter/bloc.dart';
import 'package:routing_example/pages/about/page.dart';
import 'package:routing_example/pages/home/page.dart';

void main() {
  coralTestGroup(
    'ABC-1',
    (userStoryId) {
      coralTestMockedApp<CoralMockedApp>(
        '''As a developer, I want to see an example of declarative routing, so that I can see an alternative to imperative routing.''',
        userStoryId: userStoryId,
        screenshotDir: 'declarative_route',
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
            expectedAnalytics: ['Screen: Home'],
          );

          await screenshot(
            description: '''Should be able to change the Home Page's count''',
            actions: (userAction, testerAction) async {
              await userAction.tap(find.text('Increment'));
              await userAction.tap(find.text('Increment'));
              await userAction.tap(find.text('Decrement'));
              await testerAction.pumpAndSettle();
            },
            expectations: (expect) async {
              expect(
                find.text('Count: 1'),
                findsOneWidget,
                reason: 'Count should be at 1',
              );
            },
            expectedEvents: [
              CounterEvent_Increment,
              CounterEvent_Increment,
              CounterEvent_Decrement,
            ],
            expectedAnalytics: [
              'Track: Counter: Increment',
              'Track: Counter: Increment',
              'Track: Counter: Decrement',
            ],
          );

          await screenshot(
            description:
                '''If we navigate to the about page, we should see the about page''',
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
            expectedEvents: [AppEvent_ToAboutPage],
            expectedAnalytics: ['Screen: About'],
          );

          await screenshot(
            description:
                '''Since we defined a stack in our App_Flows, we have a stack of pages (about page on top of home page). If we pop the about page off, and go back to the home page, the home page's count should be preserved.''',
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
                find.text('Count: 1'),
                findsOneWidget,
                reason: 'Count should still be at 1',
              );
            },
            expectedEvents: [AppEvent_ToHomePage],
            expectedAnalytics: ['Screen: Home'],
          );
        },
      );
    },
  );
}
