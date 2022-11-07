import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_example/blocs/todos/todos_bloc.dart';
import 'package:todo_example/pages/home/widgets_dumb/todo_input.dart';

class HomeC_TodoInput extends StatelessWidget {
  const HomeC_TodoInput({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeD_TodoInput(
      placeholderLabel: 'What needs to be done?',
      onSubmitted: (value) {
        final todosBloc = context.read<TodosBloc>();

        todosBloc.add(TodosEvent_AddTodoItem(item: value));
      },
    );
  }
}
