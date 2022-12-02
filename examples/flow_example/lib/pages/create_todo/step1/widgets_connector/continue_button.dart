import 'package:flow_example/app/app_builder.dart';
import 'package:flow_example/blocs/create_todo/create_todo_bloc.dart';
import 'package:flow_example/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateTodoStep1C_ContinueButton extends StatelessWidget {
  const CreateTodoStep1C_ContinueButton({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ElevatedButton(
      onPressed: () {
        // Add Task to TodoItem
        context
            .read<CreateTodoBloc>()
            .add(CreateTodoEvent_AddTaskToTodo(task: controller.text));

        // Then continue to next step in creation flow
        GoRouter.of(context).goNamed(
          AppRoutes.createTodo.name,
          params: {'step': '2'},
          extra: context.read<CreateTodoBloc>(),
        );
      },
      child: Text(l10n.createTodoStep1_continue),
    );
  }
}