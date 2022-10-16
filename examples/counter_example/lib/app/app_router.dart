import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:counter_example/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppRoutes { home }

GoRouter appRouter({
  required CoralAnalyticsRepository? analyticsRepository,
}) =>
    GoRouter(
      observers: [
        CoralAnalyticRouteObserver(analyticsRepository: analyticsRepository),
      ],
      routes: <GoRoute>[
        GoRoute(
          name: AppRoutes.home.name,
          path: '/',
          builder: (BuildContext context, GoRouterState state) =>
              const Home_Page(),
        ),
      ],
    );
