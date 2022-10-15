import 'dart:async';

import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routing_example/app/app_router.dart';
import 'package:routing_example/blocs/authentication/authentication_bloc.dart';
import 'package:routing_example/repositories/authentication/authentication_repository.dart';

FutureOr<Widget> appBuilder({
  CoralAnalyticsRepository? analyticsRepository,
  required AuthenticationRepository authenticationRepository,
}) {
  return App(
    analyticsRepository: analyticsRepository,
    authenticationRepository: authenticationRepository,
  );
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.analyticsRepository,
    required this.authenticationRepository,
  });

  final CoralAnalyticsRepository? analyticsRepository;
  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: analyticsRepository),
        RepositoryProvider.value(value: authenticationRepository),
      ],
      child: BlocProvider<AuthenticationBloc>(
        lazy: false,
        create: (_) {
          return AuthenticationBloc(
            authenticationRepository: authenticationRepository,
          )..add(AuthenticationEvent_Initialize());
        },
        child: Builder(
          builder: (contextB) {
            // Note: this is necessary to ensure GoRouter's redirect doesn't
            // have a stale reference to the authentication state.
            final authenticationBloc = contextB.watch<AuthenticationBloc>();

            return MaterialApp.router(
              routerConfig: appRouter(authenticationBloc.state),
            );
          },
        ),
      ),
    );
  }
}
