import 'package:flow_example/blocs/create_todo/create_todo_bloc.dart';
import 'package:flow_example/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTodoStep2C_ContinueButton extends StatelessWidget {
  const CreateTodoStep2C_ContinueButton({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ElevatedButton(
      onPressed: () {
        context
            .read<CreateTodoBloc>()
            .add(CreateTodoEvent_AddPriorityToTodo(priority: controller.text));
      },
      child: Text(l10n.createTodoStep2_continue),
    );
  }
}
