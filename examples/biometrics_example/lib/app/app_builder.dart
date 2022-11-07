import 'dart:async';

import 'package:biometrics_example/blocs/authentication/authentication_bloc.dart';
import 'package:biometrics_example/l10n/l10n.dart';
import 'package:biometrics_example/pages/home/home_page.dart';
import 'package:biometrics_example/pages/loading/loading_page.dart';
import 'package:biometrics_example/pages/login/login_page.dart';
import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:coral_biometrics_repository/coral_biometrics_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

enum AppRoutes { loading, home, login }

FutureOr<Widget> appBuilder({
  CoralAnalyticsRepository? analyticsRepository,
  required CoralBiometricsRepository biometricsRepository,
}) {
  return App(
    analyticsRepository: analyticsRepository,
    biometricsRepository: biometricsRepository,
  );
}

class App extends StatelessWidget {
  App({
    super.key,
    required this.analyticsRepository,
    required this.biometricsRepository,
  }) : _routerConfig = GoRouter(
          observers: [
            CoralAnalyticRouteObserver(
              analyticsRepository: analyticsRepository,
            ),
          ],
          routes: <GoRoute>[
            GoRoute(
              name: AppRoutes.loading.name,
              path: '/loading',
              builder: (BuildContext context, GoRouterState state) =>
                  const Loading_Page(),
            ),
            GoRoute(
              name: AppRoutes.login.name,
              path: '/login',
              builder: (BuildContext context, GoRouterState state) =>
                  const Login_Page(),
            ),
            GoRoute(
              name: AppRoutes.home.name,
              path: '/',
              builder: (BuildContext context, GoRouterState state) =>
                  const Home_Page(),
            ),
          ],
          redirect: (context, state) {
            final biometricsStatus =
                context.read<AuthenticationBloc>().state.biometricsStatus;

            if (biometricsStatus == CoralBiometricsStatus.unknown &&
                state.location != '/loading') {
              return '/loading';
            }

            return null;
          },
        );

  final CoralAnalyticsRepository? analyticsRepository;
  final CoralBiometricsRepository biometricsRepository;
  final GoRouter _routerConfig;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: analyticsRepository,
        ),
        RepositoryProvider.value(
          value: biometricsRepository,
        ),
      ],
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          biometricsRepository: context.read<CoralBiometricsRepository>(),
        ),
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
