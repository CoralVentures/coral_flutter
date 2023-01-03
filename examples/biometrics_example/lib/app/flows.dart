import 'package:auto_route/auto_route.dart';
import 'package:coral_biometrics_repository/coral_biometrics_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication/bloc.dart';
import 'router.dart';

class App_Flows extends StatelessWidget {
  const App_Flows({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
        biometricsRepository: context.read<CoralBiometricsRepository>(),
      ),
      child: const _Flows(),
    );
  }
}

class _Flows extends StatelessWidget {
  const _Flows();

  @override
  Widget build(BuildContext context) {
    final authenticationState = context.watch<AuthenticationBloc>().state;
    return AutoRouter.declarative(
      routes: (_) {
        switch (authenticationState.biometricsStatus) {
          case CoralBiometricsStatus.unknown:
            return [
              const Loading_PageRoute(),
            ];
          case CoralBiometricsStatus.unsupported:
          case CoralBiometricsStatus.supportedButNotSetUp:
          case CoralBiometricsStatus.authenticationFailed:
            return [
              const Login_PageRoute(),
            ];
          case CoralBiometricsStatus.authenticationPassed:
            return [
              const Home_PageRoute(),
            ];
        }
      },
    );
  }
}
