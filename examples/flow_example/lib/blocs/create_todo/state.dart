// ignore_for_file: sort_constructors_first

part of 'bloc.dart';

enum CreateTodoSteps {
  step1,
  step2,
  step3,
}

@JsonSerializable()
class CreateTodoState extends Equatable {
  const CreateTodoState({
    required this.step,
    required this.todoItem,
    required this.todoCreated,
  });

  const CreateTodoState.initialState()
      : step = CreateTodoSteps.step1,
        todoItem = const TodoItem(task: null, priority: null, assignee: null),
        todoCreated = false;

  // coverage:ignore-start
  factory CreateTodoState.fromJson(Map<String, dynamic> json) =>
      _$CreateTodoStateFromJson(json);

  Map<String, dynamic> toJson() => _$CreateTodoStateToJson(this);
  // coverage:ignore-end

  final CreateTodoSteps step;
  final TodoItem todoItem;
  final bool todoCreated;

  @override
  List<Object?> get props => [step, todoItem, todoCreated];
}
