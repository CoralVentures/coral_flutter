import 'dart:async';

import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:flow_example/blocs/create_todo/create_todo_bloc.dart';
import 'package:flow_example/blocs/todos/todos_bloc.dart';
import 'package:flow_example/l10n/l10n.dart';
import 'package:flow_example/pages/create_todo/step1/create_todo_step1_page.dart';
import 'package:flow_example/pages/create_todo/step2/create_todo_step2_page.dart';
import 'package:flow_example/pages/create_todo/step3/create_todo_step3_page.dart';
import 'package:flow_example/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

enum AppRoutes { home, createTodo }

FutureOr<Widget> appBuilder({
  CoralAnalyticsRepository? analyticsRepository,
}) {
  return App(analyticsRepository: analyticsRepository);
}

class App extends StatelessWidget {
  App({
    super.key,
    required this.analyticsRepository,
  }) : _routerConfig = GoRouter(
          observers: [
            CoralAnalyticRouteObserver(
              analyticsRepository: analyticsRepository,
            ),
          ],
          routes: <GoRoute>[
            GoRoute(
              name: AppRoutes.home.name,
              path: '/',
              builder: (context, state) {
                return const Home_Page();
              },
              routes: [
                GoRoute(
                  name: AppRoutes.createTodo.name,
                  path: 'todo/create/:step(1|2|3|)',
                  builder: (context, state) {
                    final createTodoBloc = state.extra! as CreateTodoBloc;

                    final step = int.parse(state.params['step']!);
                    switch (step) {
                      case 2:
                        return CreateTodoStep2_Page(
                          createTodoBloc: createTodoBloc,
                        );
                      case 3:
                        return CreateTodoStep3_Page(
                          createTodoBloc: createTodoBloc,
                        );
                      default:
                        return CreateTodoStep1_Page(
                          createTodoBloc: createTodoBloc,
                        );
                    }
                  },
                ),
              ],
            ),
          ],
        );

  final GoRouter _routerConfig;
  final CoralAnalyticsRepository? analyticsRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: analyticsRepository,
      child: BlocProvider(
        // This is utilizing the `Bloc on Top` pattern because we want this bloc
        // to be accessible by the home page and the create todo flow.
        create: (context) => TodosBloc(),
        child: MaterialApp.router(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: _routerConfig,
        ),
      ),
    );
  }
}
