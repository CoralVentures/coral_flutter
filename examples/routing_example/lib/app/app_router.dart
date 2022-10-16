import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:routing_example/blocs/authentication/authentication_bloc.dart';
import 'package:routing_example/pages/home/home_page.dart';
import 'package:routing_example/pages/login/login_page.dart';

enum AppRoutes { login, home }

GoRouter appRouter({
  required AuthenticationState authenticationState,
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
          name: AppRoutes.login.name,
          path: '/login',
          builder: (BuildContext context, GoRouterState state) =>
              const Login_Page(),
        ),
      ],
      redirect: (BuildContext context, GoRouterState state) async {
        final isAuthenticated = authenticationState.isAuthenticated;
        final isLoginRoute = state.subloc == '/login';

        /// If not authenticated, and going anywhere, redirect to `/login` route.
        if (!isAuthenticated) {
          return isLoginRoute ? null : '/login';
        }

        /// If authenticated, but attempting to go to the `/login` route, redirect them to `/` route.
        if (isLoginRoute) {
          return '/';
        }

        /// Otherwise don't redirect
        return null;
      },
    );
