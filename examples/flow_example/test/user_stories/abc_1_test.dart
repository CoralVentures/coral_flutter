import 'package:coral_tester/coral_tester.dart';
import 'package:flow_example/app/app_builder.dart';
import 'package:flow_example/blocs/analytic_listeners.dart';
import 'package:flow_example/blocs/create_todo/create_todo_bloc.dart';
import 'package:flow_example/blocs/todos/todos_bloc.dart';
import 'package:flow_example/pages/create_todo/step1/create_todo_step1_page.dart';
import 'package:flow_example/pages/create_todo/step1/widgets_connector/continue_button.dart';
import 'package:flow_example/pages/create_todo/step1/widgets_connector/task_input.dart';
import 'package:flow_example/pages/create_todo/step2/create_todo_step2_page.dart';
import 'package:flow_example/pages/create_todo/step2/widgets_connector/continue_button.dart';
import 'package:flow_example/pages/create_todo/step2/widgets_connector/priority_input.dart';
import 'package:flow_example/pages/create_todo/step3/create_todo_step3_page.dart';
import 'package:flow_example/pages/create_todo/step3/widgets_connector/assignee_input.dart';
import 'package:flow_example/pages/create_todo/step3/widgets_connector/submit_button.dart';
import 'package:flow_example/pages/home/home_page.dart';
import 'package:flow_example/pages/home/widgets_connector/create_todo_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  coralTestGroup('ABC-1', (userStoryId) {
    coralTestMockedApp(
      '''As a user, I should be able to create a todo item, so that I can keep track of what needs to be done.''',
      userStoryId: userStoryId,
      mockedApp: CoralMockedApp(appBuilder: appBuilder),
      analyticListeners: analyticListeners,
      screenshotDir: 'create_todo',
      test: (screenshot) async {
        await screenshot(
          comment: 'Should start with no TODOs',
          runExpectations: (expect) {
            expect(
              find.byType(Home_Page),
              findsOneWidget,
              reason: 'Should start on the Home Page',
            );
            expect(
              find.byType(HomeC_CreateTodoButton),
              findsOneWidget,
              reason: 'Should see button to create a TODO',
            );
          },
          expectedEvents: [],
          expectedAnalytics: ['Screen: home'],
        );

        await screenshot(
          comment:
              '''After tapping create todo button, should be asked to enter task''',
          takeActions: (userAction, testerAction) async {
            await userAction.tap(
              find.byType(HomeC_CreateTodoButton),
            );
            await testerAction.pumpAndSettle();
          },
          runExpectations: (expect) {
            expect(
              find.byType(CreateTodoStep1_Page),
              findsOneWidget,
              reason: 'Should be on the Step1 page',
            );
            expect(
              find.byType(CreateTodoStep1C_TaskInput),
              findsOneWidget,
              reason: 'Should see input to enter the task',
            );
          },
          expectedEvents: [],
          expectedAnalytics: ['Screen: createTodo'],
        );

        await screenshot(
          comment: '''Should be able to enter the task''',
          takeActions: (userAction, testerAction) async {
            await userAction.enterText(
              find.byType(CreateTodoStep1C_TaskInput),
              'Take out the trash',
            );
            await testerAction.pumpAndSettle();
          },
          runExpectations: (expect) {
            expect(
              find.text('Take out the trash'),
              findsOneWidget,
              reason: 'Should see the task entered in the input field',
            );
          },
          expectedEvents: [],
          expectedAnalytics: [],
        );

        await screenshot(
          comment: '''Should be able to continue after entering the task''',
          takeActions: (userAction, testerAction) async {
            await userAction.tap(
              find.byType(CreateTodoStep1C_ContinueButton),
            );
            await testerAction.pumpAndSettle();
          },
          runExpectations: (expect) {
            expect(
              find.byType(CreateTodoStep2_Page),
              findsOneWidget,
              reason: 'Should be on the step 2 page',
            );
          },
          expectedEvents: [CreateTodoEvent_AddTaskToTodo],
          expectedAnalytics: ['Track: Create TODO: Add Task'],
        );

        await screenshot(
          comment: '''Should be able to enter the priority''',
          takeActions: (userAction, testerAction) async {
            await userAction.enterText(
              find.byType(CreateTodoStep2C_PriorityInput),
              'High',
            );
            await testerAction.pumpAndSettle();
          },
          runExpectations: (expect) {
            expect(
              find.text('High'),
              findsOneWidget,
              reason: 'Should see the priority entered in the input field',
            );
          },
          expectedEvents: [],
          expectedAnalytics: [],
        );

        await screenshot(
          comment: '''Should be able to continue after entering the priority''',
          takeActions: (userAction, testerAction) async {
            await userAction.tap(
              find.byType(CreateTodoStep2C_ContinueButton),
            );
            await testerAction.pumpAndSettle();
          },
          runExpectations: (expect) {
            expect(
              find.byType(CreateTodoStep3_Page),
              findsOneWidget,
              reason: 'Should be on the step 3 page',
            );
          },
          expectedEvents: [CreateTodoEvent_AddPriorityToTodo],
          expectedAnalytics: ['Track: Create TODO: Add Priority'],
        );

        await screenshot(
          comment: '''Should be able to enter the assignee''',
          takeActions: (userAction, testerAction) async {
            await userAction.enterText(
              find.byType(CreateTodoStep3C_AssigneeInput),
              'Jane',
            );
            await testerAction.pumpAndSettle();
          },
          runExpectations: (expect) {
            expect(
              find.text('Jane'),
              findsOneWidget,
              reason: 'Should see the assignee entered in the input field',
            );
          },
          expectedEvents: [],
          expectedAnalytics: [],
        );

        await screenshot(
          comment: '''Should be able to submit the todo item''',
          takeActions: (userAction, testerAction) async {
            await userAction.tap(
              find.byType(CreateTodoStep3C_SubmitButton),
            );
            await testerAction.pumpAndSettle();
          },
          runExpectations: (expect) {
            expect(
              find.byType(Home_Page),
              findsOneWidget,
              reason: 'Should be on the home page',
            );
            expect(
              find.byType(ListTile),
              findsOneWidget,
              reason: 'Should have one todo item in a ListTile',
            );
          },
          expectedEvents: [
            CreateTodoEvent_AddAssigneeToTodo,
            TodosEvent_AddTodo,
          ],
          expectedAnalytics: [
            'Track: Create TODO: Add Assignee',
            'Track: Todos: Item Created',
            'Screen: home',
          ],
        );
      },
    );
  });
}
