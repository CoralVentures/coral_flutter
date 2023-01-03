import 'package:flutter/material.dart';
import '../../../../models/todo_item.dart';

class HomeD_TodoItem extends StatelessWidget {
  const HomeD_TodoItem({
    super.key,
    required this.todoItem,
    required this.onTap,
  });

  final TodoItem todoItem;
  final VoidCallback onTap;

  Icon get _icon {
    switch (todoItem.status) {
      case TodoItemStatus.active:
        return const Icon(Icons.check_box_outline_blank);
      case TodoItemStatus.completed:
        return const Icon(
          Icons.check_box_outlined,
          color: Colors.green,
        );
    }
  }

  TextStyle? get _textStyle {
    switch (todoItem.status) {
      case TodoItemStatus.active:
        return null;
      case TodoItemStatus.completed:
        return const TextStyle(
          decoration: TextDecoration.lineThrough,
          color: Colors.grey,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _icon,
      title: Text(
        todoItem.item,
        style: _textStyle,
      ),
      onTap: onTap,
    );
  }
}
