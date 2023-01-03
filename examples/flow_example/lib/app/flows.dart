import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/app/bloc.dart';
import 'router.dart';

class App_Flows extends StatelessWidget {
  const App_Flows({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(),
      child: const _Flows(),
    );
  }
}

class _Flows extends StatelessWidget {
  const _Flows();

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppBloc>().state;
    return AutoRouter.declarative(
      routes: (_) {
        switch (appState.flow) {
          case AppFlows.home:
            return [
              const Home_PageRoute(),
            ];
          case AppFlows.createTodo:
            return [
              const CreateTodo_FlowRoute(),
            ];
        }
      },
    );
  }
}
