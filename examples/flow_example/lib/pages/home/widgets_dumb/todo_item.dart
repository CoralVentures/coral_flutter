import 'package:flow_example/blocs/todos/models/todo_item.dart';
import 'package:flutter/material.dart';

class HomeD_TodoItem extends StatelessWidget {
  const HomeD_TodoItem({
    super.key,
    required this.todoItem,
  });

  final TodoItem todoItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todoItem.task!),
      subtitle: Text(todoItem.assignee!),
      trailing: Text(todoItem.priority!),
    );
  }
}
