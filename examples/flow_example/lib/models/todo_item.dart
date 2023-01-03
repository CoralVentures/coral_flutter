import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_item.g.dart';

@JsonSerializable()
class TodoItem extends Equatable {
  const TodoItem({
    required this.task,
    required this.priority,
    required this.assignee,
  });

  // coverage:ignore-start
  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);

  Map<String, dynamic> toJson() => _$TodoItemToJson(this);
  // coverage:ignore-end

  final String? task;
  final String? priority;
  final String? assignee;

  TodoItem copyWith({
    String? task,
    String? priority,
    String? assignee,
  }) {
    return TodoItem(
      task: task ?? this.task,
      priority: priority ?? this.priority,
      assignee: assignee ?? this.assignee,
    );
  }

  @override
  List<Object?> get props => [task, priority, assignee];
}
