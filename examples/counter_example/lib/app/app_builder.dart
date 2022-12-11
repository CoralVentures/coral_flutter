import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:counter_example/app/app_router.dart';
import 'package:counter_example/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

FutureOr<Widget> appBuilder({
  CoralAnalyticsRepository? analyticsRepository,
}) {
  return App(analyticsRepository: analyticsRepository);
}

class App extends StatelessWidget {
  App({
    super.key,
    required this.analyticsRepository,
  }) : _appRouter = AppRouter();

  final CoralAnalyticsRepository? analyticsRepository;
  final AppRouter _appRouter;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: analyticsRepository,
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
              const Home_PageRoute(),
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
