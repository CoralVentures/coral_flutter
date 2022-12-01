// ignore_for_file: always_use_package_imports
import 'package:coral_bloc/coral_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flow_example/blocs/todos/models/todo_item.dart';
import 'package:json_annotation/json_annotation.dart';

import '../bloc_type.dart';
import '../redux_remote_devtools.dart';

part 'create_todo_bloc.g.dart';

part 'create_todo_event.dart';
part 'create_todo_state.dart';

class CreateTodoBloc extends CoralBloc<CreateTodoEvent, CreateTodoState> {
  CreateTodoBloc()
      : super(
          const CreateTodoState.initialState(),
          blocType: BlocType.createTodo.name,
          beforeOnEvent: remoteReduxDevtoolsOnEvent,
          beforeOnClose: remoteReduxDevtoolsOnClose,
        );

  @override
  Stream<CreateTodoState> mapEventToState(
    CreateTodoEvent event,
  ) async* {
    switch (event.eventType) {
      case CreateTodoEvents.addTaskToTodo:
        {
          final _event = event as CreateTodoEvent_AddTaskToTodo;
          final todoItem = state.todoItem.copyWith(task: _event.task);
          yield CreateTodoState(todoItem: todoItem, todoCreated: false);
        }

        break;
      case CreateTodoEvents.addPriorityToTodo:
        {
          final _event = event as CreateTodoEvent_AddPriorityToTodo;
          final todoItem = state.todoItem.copyWith(priority: _event.priority);
          yield CreateTodoState(todoItem: todoItem, todoCreated: false);
        }
        break;
      case CreateTodoEvents.addAssigneeToTodo:
        {
          final _event = event as CreateTodoEvent_AddAssigneeToTodo;
          final todoItem = state.todoItem.copyWith(assignee: _event.assignee);
          yield CreateTodoState(todoItem: todoItem, todoCreated: true);
        }
        break;
    }
  }
}
