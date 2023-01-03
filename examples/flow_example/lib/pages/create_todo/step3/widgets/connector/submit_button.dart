import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../blocs/app/bloc.dart';
import '../../../../../blocs/create_todo/bloc.dart';
import '../../../../../blocs/todos/bloc.dart';
import '../../../../../l10n/l10n.dart';

class CreateTodoStep3C_SubmitButton extends StatelessWidget {
  const CreateTodoStep3C_SubmitButton({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocListener<CreateTodoBloc, CreateTodoState>(
      child: ElevatedButton(
        onPressed: () {
          // 1) Add Assignee to TodoItem
          final createTodoBloc = context.read<CreateTodoBloc>();
          createTodoBloc.add(
            CreateTodoEvent_AddAssigneeToTodo(assignee: controller.text),
          );

          // Continued in listener callback
        },
        child: Text(l10n.createTodoStep3_submit),
      ),
      listenWhen: (previous, current) {
        return previous.todoCreated != current.todoCreated;
      },
      listener: (context, state) {
        // 2) Add todo item to TodosBloc
        final todosBloc = context.read<TodosBloc>();
        todosBloc.add(TodosEvent_AddTodo(todoItem: state.todoItem));

        // 3) Navigate back to home page
        context.read<AppBloc>().add(const AppEvent_ToHomeFlow());
      },
    );
  }
}
