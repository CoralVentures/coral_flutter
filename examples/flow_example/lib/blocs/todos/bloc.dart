// ignore_for_file: always_use_package_imports
import 'package:coral_bloc/coral_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../models/todo_item.dart';
import '../bloc_type.dart';
import '../redux_remote_devtools.dart';

part 'bloc.g.dart';
part 'event.dart';
part 'state.dart';

class TodosBloc extends CoralBloc<TodosEvent, TodosState> {
  TodosBloc()
      : super(
          const TodosState.initialState(),
          blocType: BlocType.todos.name,
          beforeOnEvent: remoteReduxDevtoolsOnEvent,
          beforeOnClose: remoteReduxDevtoolsOnClose,
        );

  @override
  Stream<TodosState> mapEventToState(
    TodosEvent event,
  ) async* {
    switch (event.eventType) {
      case TodosEvents.addTodo:
        {
          final _event = event as TodosEvent_AddTodo;
          final todoItems = List<TodoItem>.from(state.todoItems);
          yield TodosState(todoItems: todoItems..add(_event.todoItem));
        }
        break;
    }
  }
}
