import 'package:auto_route/auto_route.dart';
import 'package:flow_example/app/app_router.dart';
import 'package:flow_example/blocs/create_todo/create_todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTodo_Flow extends StatelessWidget {
  const CreateTodo_Flow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTodoBloc(),
      child: const _FlowRoutes(),
    );
  }
}

class _FlowRoutes extends StatelessWidget {
  const _FlowRoutes();

  @override
  Widget build(BuildContext context) {
    final createTodoState = context.watch<CreateTodoBloc>().state;
    return AutoRouter.declarative(
      routes: (_) {
        switch (createTodoState.step) {
          case CreateTodoSteps.step1:
            return [
              const CreateTodoStep1_PageRoute(),
            ];
          case CreateTodoSteps.step2:
            return [
              const CreateTodoStep1_PageRoute(),
              const CreateTodoStep2_PageRoute(),
            ];
          case CreateTodoSteps.step3:
            return [
              const CreateTodoStep1_PageRoute(),
              const CreateTodoStep2_PageRoute(),
              const CreateTodoStep3_PageRoute(),
            ];
        }
      },
    );
  }
}
