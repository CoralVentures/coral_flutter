part of 'todos_bloc.dart';

enum TodosEvents {
  addTodo,
}

abstract class TodosEvent extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  const TodosEvent(this.eventType);

  final TodosEvents eventType;

  @override
  List<Object> get props => [eventType];
}

class TodosEvent_AddTodo extends TodosEvent {
  const TodosEvent_AddTodo({
    required this.todoItem,
  }) : super(TodosEvents.addTodo);

  final TodoItem todoItem;

  @override
  List<Object> get props => super.props..addAll([todoItem]);
}
