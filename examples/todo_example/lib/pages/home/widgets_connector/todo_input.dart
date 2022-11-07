import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_example/blocs/todos/todos_bloc.dart';
import 'package:todo_example/l10n/l10n.dart';
import 'package:todo_example/pages/home/widgets_dumb/todo_input.dart';

class HomeC_TodoInput extends StatelessWidget {
  const HomeC_TodoInput({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return HomeD_TodoInput(
      placeholderLabel: l10n.home_todoPlaceholder,
      onSubmitted: (value) {
        final todosBloc = context.read<TodosBloc>();

        todosBloc.add(TodosEvent_AddTodoItem(item: value));
      },
    );
  }
}
