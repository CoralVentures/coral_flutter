part of 'bloc.dart';

enum CreateTodoEvents {
  addTaskToTodo,
  addPriorityToTodo,
  addAssigneeToTodo,
}

abstract class CreateTodoEvent extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  const CreateTodoEvent(this.eventType);

  final CreateTodoEvents eventType;

  @override
  List<Object> get props => [eventType];
}

class CreateTodoEvent_AddTaskToTodo extends CreateTodoEvent {
  const CreateTodoEvent_AddTaskToTodo({
    required this.task,
  }) : super(CreateTodoEvents.addTaskToTodo);

  final String task;

  @override
  List<Object> get props => super.props..addAll([task]);
}

class CreateTodoEvent_AddPriorityToTodo extends CreateTodoEvent {
  const CreateTodoEvent_AddPriorityToTodo({
    required this.priority,
  }) : super(CreateTodoEvents.addPriorityToTodo);

  final String priority;

  @override
  List<Object> get props => super.props..addAll([priority]);
}

class CreateTodoEvent_AddAssigneeToTodo extends CreateTodoEvent {
  const CreateTodoEvent_AddAssigneeToTodo({
    required this.assignee,
  }) : super(CreateTodoEvents.addAssigneeToTodo);

  final String assignee;

  @override
  List<Object> get props => super.props..addAll([assignee]);
}
