// ignore_for_file: always_use_package_imports
import 'package:coral_bloc/coral_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todo_example/blocs/todos/models/todo_item.dart';
import 'package:uuid/uuid.dart';

import '../bloc_type.dart';
import '../redux_remote_devtools.dart';

part 'todos_bloc.g.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends CoralBloc<TodosEvent, TodosState> {
  TodosBloc()
      : super(
          const TodosState.initialState(),
          blocType: BlocType.todos.name,
          beforeOnEvent: remoteReduxDevtoolsOnEvent,
          beforeOnClose: remoteReduxDevtoolsOnClose,
        );

  final uuid = const Uuid();

  @override
  Stream<TodosState> mapEventToState(
    TodosEvent event,
  ) async* {
    switch (event.eventType) {
      case TodosEvents.addTodoItem:
        {
          final _event = event as TodosEvent_AddTodoItem;
          final todoItems = List<TodoItem>.from(state.todoItems)
            ..add(
              TodoItem(
                id: uuid.v4(),
                item: _event.item,
                status: TodoItemStatus.active,
              ),
            );

          yield TodosState(todoItems: todoItems);
        }
        break;

      case TodosEvents.completeTodoItem:
        {
          final _event = event as TodosEvent_CompleteTodoItem;
          final todoItems = List<TodoItem>.from(state.todoItems);
          final todoIndex =
              todoItems.indexWhere((item) => item.id == _event.itemId);

          todoItems[todoIndex] =
              todoItems[todoIndex].copyWithStatus(TodoItemStatus.completed);

          yield TodosState(todoItems: todoItems);
        }
        break;

      case TodosEvents.activateTodoItem:
        {
          final _event = event as TodosEvent_ActivateTodoItem;
          final todoItems = List<TodoItem>.from(state.todoItems);
          final todoIndex =
              todoItems.indexWhere((item) => item.id == _event.itemId);

          todoItems[todoIndex] =
              todoItems[todoIndex].copyWithStatus(TodoItemStatus.active);

          yield TodosState(todoItems: todoItems);
        }
        break;
    }
  }
}
