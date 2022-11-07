import 'dart:async';

import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:routing_example/l10n/l10n.dart';
import 'package:routing_example/pages/about/about_page.dart';
import 'package:routing_example/pages/home/home_page.dart';

enum AppRoutes { home, about }

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
              builder: (BuildContext context, GoRouterState state) =>
                  const Home_Page(),
            ),
            GoRoute(
              name: AppRoutes.about.name,
              path: '/about',
              builder: (BuildContext context, GoRouterState state) =>
                  const About_Page(),
            ),
          ],
        );

  final CoralAnalyticsRepository? analyticsRepository;

  final GoRouter _routerConfig;

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
        routerConfig: _routerConfig,
      ),
    );
  }
}
