part of 'todos_bloc.dart';

enum TodosEvents {
  addTodoItem,
  completeTodoItem,
  activateTodoItem,
}

abstract class TodosEvent extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  const TodosEvent(this.eventType);

  final TodosEvents eventType;

  @override
  List<Object> get props => [eventType];
}

class TodosEvent_AddTodoItem extends TodosEvent {
  const TodosEvent_AddTodoItem({
    required this.item,
  }) : super(TodosEvents.addTodoItem);

  final String item;

  @override
  List<Object> get props => super.props..addAll([item]);
}

class TodosEvent_CompleteTodoItem extends TodosEvent {
  const TodosEvent_CompleteTodoItem({
    required this.itemId,
  }) : super(TodosEvents.completeTodoItem);

  final String itemId;

  @override
  List<Object> get props => super.props..addAll([itemId]);
}

class TodosEvent_ActivateTodoItem extends TodosEvent {
  const TodosEvent_ActivateTodoItem({
    required this.itemId,
  }) : super(TodosEvents.activateTodoItem);

  final String itemId;

  @override
  List<Object> get props => super.props..addAll([itemId]);
}
