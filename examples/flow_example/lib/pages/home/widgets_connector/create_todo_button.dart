import 'package:flow_example/app/app_builder.dart';
import 'package:flow_example/blocs/create_todo/create_todo_bloc.dart';
import 'package:flow_example/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeC_CreateTodoButton extends StatelessWidget {
  const HomeC_CreateTodoButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ElevatedButton(
      onPressed: () {
        GoRouter.of(context).goNamed(
          AppRoutes.createTodo.name,
          params: {'step': '1'},
          // Creating CreateTodoBloc here which means we will need to manually
          // close it when we are done with it. (See Submit Button in step 3.)
          extra: CreateTodoBloc(),
        );
      },
      child: Text(l10n.home_createTodoItem),
    );
  }
}
