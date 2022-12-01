import 'package:flow_example/app/app_builder.dart';
import 'package:flow_example/blocs/create_todo/create_todo_bloc.dart';
import 'package:flow_example/blocs/todos/todos_bloc.dart';
import 'package:flow_example/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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

          // 2) Close bloc
          createTodoBloc.close();

          // Continued in listener callback
        },
        child: Text(l10n.createTodoStep3_submit),
      ),
      listenWhen: (previous, current) {
        return previous.todoCreated != current.todoCreated;
      },
      listener: (context, state) {
        // 3) Add todo item to TodosBloc
        final todosBloc = context.read<TodosBloc>();
        todosBloc.add(TodosEvent_AddTodo(todoItem: state.todoItem));

        // 4) Navigate back to home page
        GoRouter.of(context).goNamed(
          AppRoutes.home.name,
        );
      },
    );
  }
}
