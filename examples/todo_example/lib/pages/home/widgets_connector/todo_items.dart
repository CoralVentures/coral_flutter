import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_example/blocs/todos/models/todo_item.dart';
import 'package:todo_example/blocs/todos/todos_bloc.dart';
import 'package:todo_example/pages/home/widgets_dumb/todo_item.dart';

class HomeC_TodoItems extends StatelessWidget {
  const HomeC_TodoItems({super.key});

  @override
  Widget build(BuildContext context) {
    final todosBloc = context.watch<TodosBloc>();
    final todoItems = todosBloc.state.todoItems;

    final todoItemWidgets = <Widget>[];

    for (final item in todoItems) {
      todoItemWidgets.add(
        HomeD_TodoItem(
          todoItem: item,
          onTap: () {
            switch (item.status) {
              case TodoItemStatus.active:
                todosBloc.add(TodosEvent_CompleteTodoItem(itemId: item.id));
                break;
              case TodoItemStatus.completed:
                todosBloc.add(TodosEvent_ActivateTodoItem(itemId: item.id));
                break;
            }
          },
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: todoItemWidgets,
    );
  }
}
