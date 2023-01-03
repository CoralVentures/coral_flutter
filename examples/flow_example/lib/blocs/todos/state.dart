// ignore_for_file: sort_constructors_first

part of 'bloc.dart';

@JsonSerializable()
class TodosState extends Equatable {
  const TodosState({
    required this.todoItems,
  });

  const TodosState.initialState() : todoItems = const [];

  // coverage:ignore-start
  factory TodosState.fromJson(Map<String, dynamic> json) =>
      _$TodosStateFromJson(json);

  Map<String, dynamic> toJson() => _$TodosStateToJson(this);
  // coverage:ignore-end

  final List<TodoItem> todoItems;

  @override
  List<Object?> get props => [todoItems];
}
