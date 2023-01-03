import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:coral_biometrics_repository/coral_biometrics_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../l10n/l10n.dart';
import 'router.dart';

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
  }) : _appRouter = AppRouter();

  final CoralAnalyticsRepository? analyticsRepository;
  final CoralBiometricsRepository biometricsRepository;
  final AppRouter _appRouter;

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
      child: MaterialApp.router(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        routerDelegate: AutoRouterDelegate.declarative(
          _appRouter,
          routes: (handler) {
            return [
              const App_FlowsRoute(),
            ];
          },
          navigatorObservers: () => [
            CoralAnalyticRouteObserver(
              analyticsRepository: analyticsRepository,
            ),
          ],
        ),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
}
