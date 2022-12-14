import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/todos/bloc.dart';
import '../dumb/todo_item.dart';

class HomeC_TodoItems extends StatelessWidget {
  const HomeC_TodoItems({super.key});

  @override
  Widget build(BuildContext context) {
    final todosBloc = context.watch<TodosBloc>();
    final todoItems = todosBloc.state.todoItems;

    final todoItemWidgets = <Widget>[];

    for (final item in todoItems) {
      todoItemWidgets.add(
        HomeD_TodoItem(todoItem: item),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: todoItemWidgets,
    );
  }
}
