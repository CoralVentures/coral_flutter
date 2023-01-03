import 'package:coral_tester/coral_tester.dart';
import 'package:double_yield_example/app/builder.dart';
import 'package:double_yield_example/blocs/analytic_listeners.dart';
import 'package:double_yield_example/blocs/greetings/bloc.dart';
import 'package:double_yield_example/pages/home/widgets/connector/say_hello_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  coralTestGroup('ABC-1', (userStoryId) {
    coralTestMockedApp<CoralMockedApp>(
      '''As a developer, I want to see an example of the "double-yield" pattern to trigger things like a snack bar''',
      userStoryId: userStoryId,
      screenshotDir: 'snack_bar',
      mockedApp: CoralMockedApp(appBuilder: appBuilder),
      analyticListeners: analyticListeners,
      test: (screenshot) async {
        await screenshot(
          description: 'Should see a single button to trigger a snack bar',
          expectations: (expect) {
            expect(
              find.byType(HomeC_SayHelloButton),
              findsOneWidget,
              reason: 'Should see say hello button',
            );
          },
          expectedEvents: [],
          expectedAnalytics: ['Screen: Home'],
        );

        await screenshot(
          description: '''After tapping button, should see a snack bar''',
          actions: (userAction, testerAction) async {
            await userAction.tap(
              find.byType(HomeC_SayHelloButton),
            );
            await testerAction.pumpAndSettle();
          },
          expectations: (expect) {
            expect(
              find.byType(SnackBar),
              findsOneWidget,
              reason: 'Should see a snack bar',
            );
          },
          expectedEvents: [GreetingsEvent_SayHello],
          expectedAnalytics: [],
        );
      },
    );
  });
}
