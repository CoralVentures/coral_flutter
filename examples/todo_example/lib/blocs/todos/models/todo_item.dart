import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_item.g.dart';

enum TodoItemStatus { active, completed }

@JsonSerializable()
class TodoItem extends Equatable {
  const TodoItem({
    required this.id,
    required this.item,
    required this.status,
  });

  // coverage:ignore-start
  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);

  Map<String, dynamic> toJson() => _$TodoItemToJson(this);
  // coverage:ignore-end

  final String id;
  final String item;
  final TodoItemStatus status;

  TodoItem copyWithStatus(TodoItemStatus status) {
    return TodoItem(
      id: id,
      item: item,
      status: status,
    );
  }

  @override
  List<Object?> get props => [id, item, status];
}
