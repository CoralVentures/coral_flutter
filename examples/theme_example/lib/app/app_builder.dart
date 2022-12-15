import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:theme_example/app/app_router.dart';
import 'package:theme_example/app/app_theme.dart';
import 'package:theme_example/l10n/l10n.dart';

FutureOr<Widget> appBuilder({
  Key? key,
  CoralAnalyticsRepository? analyticsRepository,
  ThemeMode themeMode = ThemeMode.system,
}) {
  return App(
    key: key,
    analyticsRepository: analyticsRepository,
    themeMode: themeMode,
  );
}

class App extends StatelessWidget {
  App({
    super.key,
    required this.analyticsRepository,
    required this.themeMode,
  }) : _appRouter = AppRouter();

  final CoralAnalyticsRepository? analyticsRepository;
  final AppRouter _appRouter;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: analyticsRepository,
      child: MaterialApp.router(
        themeMode: themeMode,
        theme: appThemeLight,
        darkTheme: appThemeDark,
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
