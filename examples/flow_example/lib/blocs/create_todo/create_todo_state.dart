// ignore_for_file: sort_constructors_first

part of 'create_todo_bloc.dart';

@JsonSerializable()
class CreateTodoState extends Equatable {
  const CreateTodoState({
    required this.todoItem,
    required this.todoCreated,
  });

  const CreateTodoState.initialState()
      : todoItem = const TodoItem(task: null, priority: null, assignee: null),
        todoCreated = false;

  // coverage:ignore-start
  factory CreateTodoState.fromJson(Map<String, dynamic> json) =>
      _$CreateTodoStateFromJson(json);

  Map<String, dynamic> toJson() => _$CreateTodoStateToJson(this);
  // coverage:ignore-end

  final TodoItem todoItem;
  final bool todoCreated;

  @override
  List<Object?> get props => [todoItem, true];
}
