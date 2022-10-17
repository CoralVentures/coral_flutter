import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:routing_example/pages/about/about_page.dart';
import 'package:routing_example/pages/home/home_page.dart';

enum AppRoutes { home, about }

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
        GoRoute(
          name: AppRoutes.about.name,
          path: '/about',
          builder: (BuildContext context, GoRouterState state) =>
              const About_Page(),
        ),
      ],
    );
