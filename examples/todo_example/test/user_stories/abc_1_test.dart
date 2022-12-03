import 'package:coral_tester/coral_tester.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_example/app/app_builder.dart';
import 'package:todo_example/blocs/analytic_listeners.dart';
import 'package:todo_example/blocs/todos/todos_bloc.dart';
import 'package:todo_example/pages/home/widgets_dumb/todo_item.dart';

void main() {
  coralTestGroup('ABC-1', (userStoryId) {
    coralTestMockedApp(
      '''As a user, I should be able to create a todo item and mark it as complete, so I can keep track of what I need to do.''',
      userStoryId: userStoryId,
      mockedApp: CoralMockedApp(appBuilder: appBuilder),
      analyticListeners: analyticListeners,
      screenshotDir: 'todo_item',
      test: (screenshot) async {
        await screenshot(
          description:
              '''Before entering a todo item, there should be no todo items''',
          expectations: (expect) {
            expect(
              find.byType(HomeD_TodoItem),
              findsNothing,
              reason: 'Should not find todo item',
            );
          },
          expectedEvents: [],
          expectedAnalytics: ['Screen: home'],
        );

        await screenshot(
          description:
              '''Should see potential todo while typing, but shouldn't see todo item until the user has hit submit''',
          actions: (userAction, testerAction) async {
            await userAction.enterText(
              find.byType(TextField),
              'Take out the trash',
            );
            await testerAction.pumpAndSettle();
          },
          expectations: (exect) {
            expect(
              find.byType(HomeD_TodoItem),
              findsNothing,
              reason:
                  '''Should not find todo item because user has not submitted yet.''',
            );
          },
          expectedEvents: [],
          expectedAnalytics: [],
        );

        await screenshot(
          description: '''Should see todo once user hits submit.''',
          actions: (userAction, testerAction) async {
            await testerAction.testTextInput
                .receiveAction(TextInputAction.done);
            await testerAction.pumpAndSettle();
          },
          expectations: (expect) {
            expect(
              find.byType(HomeD_TodoItem),
              findsOneWidget,
              reason: '''Should see todo item''',
            );
            expect(
              find.byIcon(Icons.check_box_outline_blank),
              findsOneWidget,
              reason: '''Should see checkbox outline''',
            );
            expect(
              find.text('Take out the trash'),
              findsOneWidget,
              reason: '''Should see the todo item's text''',
            );
          },
          expectedEvents: [TodosEvent_AddTodoItem],
          expectedAnalytics: ['Track: TODO: Created'],
        );

        await screenshot(
          description:
              '''After tapping on todo, should see completed todo item.''',
          actions: (userAction, testerAction) async {
            await userAction.tap(
              find.byType(HomeD_TodoItem),
            );
            await testerAction.pumpAndSettle();
          },
          expectations: (expect) {
            expect(
              find.byWidgetPredicate((widget) {
                if (widget is Icon) {
                  final correctIcon = widget.icon == Icons.check_box_outlined;
                  final correctColor = widget.color == Colors.green;
                  return correctIcon && correctColor;
                }
                return false;
              }),
              findsOneWidget,
              reason: '''Should see green checkbox''',
            );
            expect(
              find.byWidgetPredicate((widget) {
                if (widget is Text) {
                  final correctText = widget.data == 'Take out the trash';
                  final correctDecoration =
                      widget.style?.decoration == TextDecoration.lineThrough;
                  return correctText && correctDecoration;
                }
                return false;
              }),
              findsOneWidget,
              reason:
                  '''Should see the todo item's text with a line through it''',
            );
          },
          expectedEvents: [TodosEvent_CompleteTodoItem],
          expectedAnalytics: ['Track: TODO: Completed'],
        );

        await screenshot(
          description:
              '''After tapping todo item again, should reactivate todo item.''',
          actions: (userAction, testerAction) async {
            await userAction.tap(
              find.byType(HomeD_TodoItem),
            );
            await testerAction.pumpAndSettle();
          },
          expectations: (expect) {
            expect(
              find.byIcon(Icons.check_box_outline_blank),
              findsOneWidget,
              reason: '''Should see checkbox outline''',
            );
            expect(
              find.text('Take out the trash'),
              findsOneWidget,
              reason: '''Should see the todo item's text''',
            );
          },
          expectedEvents: [TodosEvent_ActivateTodoItem],
          expectedAnalytics: ['Track: TODO: Reactivated'],
        );
      },
    );
  });
}
