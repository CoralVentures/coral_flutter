import 'package:flutter/material.dart';

import '../../../../models/todo_item.dart';

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
