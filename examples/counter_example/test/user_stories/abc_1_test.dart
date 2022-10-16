import 'package:coral_tester/coral_tester.dart';
import 'package:counter_example/app/app_builder.dart';
import 'package:counter_example/blocs/analytic_listeners.dart';
import 'package:counter_example/blocs/counter/counter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  coralTestGroup('ABC-1', (userStoryId) {
    const groupPath = 'abc_1';

    coralTestMockedApp(
      '''As a user, I should be able to change the count, so that I can keep count of things.''',
      userStoryId: userStoryId,
      mockedApp: CoralMockedApp(appBuilder: appBuilder),
      analyticListeners: analyticListeners,
      basePath: groupPath,
      test: (tester) async {
        await tester.pumpApp();

        await tester.screenshot(
          runExpectations: () {
            tester
              ..expectWithReason(
                find.text('Count: 0'),
                findsOneWidget,
                reason: 'Should see initial count of zero',
              )
              ..expectWithReason(
                find.text('Count: -1'),
                findsNothing,
                reason: 'Should not see a count of -1',
              )
              ..expectWithReason(
                find.text('Count: 1'),
                findsNothing,
                reason: 'Should not see a count of 1',
              );
          },
          expectedAnalytics: ['Screen: home'],
        );

        await tester.screenshot(
          comment: 'As a user, I want to be able to decrement the count',
          runExpectations: () {
            tester.expectWithReason(
              find.text('Count: -1'),
              findsOneWidget,
              reason: 'Should see count decremented by one',
            );
          },
          takeActions: () async {
            await tester.tap(find.text('Decrement'));
          },
          expectedEvents: [
            CounterEvent_Decrement,
          ],
          expectedAnalytics: [
            'Track: Counter: Decrement',
          ],
        );

        await tester.screenshot(
          comment: 'As a user, I want to be able to increment the count',
          runExpectations: () {
            tester.expectWithReason(
              find.text('Count: 1'),
              findsOneWidget,
              reason: 'Should see count incremented by two',
            );
          },
          takeActions: () async {
            await tester.tap(find.text('Increment'));
            await tester.tap(find.text('Increment'));
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