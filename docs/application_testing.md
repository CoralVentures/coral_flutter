# Application Testing

Flutter_bloc recommends testing the business logic directly and provides a convenience [bloc_test](https://pub.dev/packages/bloc_test) tool. However, we deviate from this recommendation and **never** test the business logic directly.

In our experience, too many bugs live in the space between the business logic and the presentation layer. So we treat the entire application layer as a black box, and limit ourselves to interact with the application the same way a user would. By doing this kind of testing, we will ensure that a user can actually 'wiggle' every line of our business logic. If they can't, then that business logic is either not wired up properly to the presentation layer or it shouldn't exist.

In short, we are favoring integration tests with mocks. We are comfortable with this approach because the tests are headless and run pretty fast.

## Set Up

Inside the `test` directory, we need to add a file called `flutter_test_config.dart`:

```dart
import 'package:coral_tester/coral_tester.dart';

const testExecutable = coralTestExecutable;
```

Flutter looks for this file and for a var called `testExecutable`. We have some predefined setup in `coralTestExecutable` that should help get us started. You can look at the source for further details.

## User Stories

Next, we will place _all_ of our application tests in a directory called `user_stories`. Each test will be `user_story_id_test.dart`, for example: abc_1_test.dart.

```md
test/
user_stories/
abc_1_test.dart
```

The purpose of this is we want our tests to be driven by **real** requirements. This will help us focus on testing things that is tied to our product.

Since we produce a gallery from our tests (and golden images), anyone can search for the user story id and find the relevant tests.

## Gallery

To view the gallery, run:

```sh
mkdocs serve
```

Then go to localhost:8000

## Coral Testing

Let's go over the counter_example tests.

```dart
void main() {
 // 1)
  coralTestGroup('ABC-1', (userStoryId) {
    // 2)
    coralTestMockedApp(
      '''As a user, I should be able to change the count, so that I can keep count of things.''',
      userStoryId: userStoryId,
      mockedApp: CoralMockedApp(appBuilder: appBuilder),
      analyticListeners: analyticListeners,
      screenshotDir: 'change_count',
      test: (screenshot) async {
    // 3)
        await screenshot(
          // 4)
          expectations: (exepect) {
            expect(
              find.text('Count: 0'),
              findsOneWidget,
              reason: 'Should see initial count of zero',
            );
          },
          // 5)
          expectedAnalytics: ['Screen: home'],
        );
        await screenshot(
          description: 'As a user, I want to be able to decrement the count',
          // 6)
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
          // 7)
          expectedEvents: [
            CounterEvent_Decrement,
          ],
          expectedAnalytics: [
            'Track: Counter: Decrement',
          ],
        );
```

1. Instead of using `group` we use `coralTestGroup`. This will use the `description` (which should be the user story id) of the group and pass it to the anonymous function as `userStoryId`.

_Note: we can't simply create a var of the description because the group's description needs to be a string literal. The way flutter runs its tests is peculiar and this is simply a limitation of it. If you try to use a var, the tests will fail to run._

2. Instead of using `test` we use `coralTestMockedApp`. _This is where the magic happens._

This will take in a mocked version of our app (we mock the repository layer), and give us a `CoralScreenshot` instead of a `WidgetTester`. The `CoralScreenshot` will keep track of various things, like analytics, tap events, our expectations, etc. The `coralTestMockedApp` uses this information (that our `CoralScreenshot` is aggregating) and turns it into the gallery.

3. Everything we do in our tests will be inside of `screenshot`. This is because every time we take a user action, we want to take a new screenshot to capture every moment along the user's journey.

4. `expecations` is a place to isolate what we expect to happen. You will have access to the `expect` function which will keep track of our expectations, so we can display them in our gallery.

5. The `CoralScreenshot` keeps track of all of the analytics we would have been sending off to Segment (or whatever our vendor of choice may be). We can then test that we are sending off the analytics that we expect to send off. Since this will also end up in the gallery, it will help our Product team understand our application and give them an opportunity to self-serve when it comes to making analytic dashboards and funnels.

6. `takeActions` is where we will simulate user actions. You will have access to `userAction` and `testerAction`.

_Note: The user actions in `userAction` are technically also available in `testerAction`, but please use `userAction` instead. This is because the user actions are sniffed when used by `userAction` and will be echoed back in the tester logs and included the gallery._

8. The `CoralScreenshot` keeps track of all of our bloc events. We can then test to make sure the bloc events are coming in as expected and in the proper order. This is especially helpful to prevent us from accidentally introducing logic that affects flows we aren't working on. These events will also be shown in the gallery (along with a graphviz image representation).
