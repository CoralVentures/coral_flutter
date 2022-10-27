import 'package:bottom_nav_example/blocs/bottom_nav/bottom_nav_bloc.dart';
import 'package:bottom_nav_example/pages/launchpad/launchpad_page.dart';
import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

enum AppRoutes { launchpad }

GoRouter appRouter({
  required CoralAnalyticsRepository? analyticsRepository,
}) =>
    GoRouter(
      initialLocation: '/initialize',
      observers: [
        CoralAnalyticRouteObserver(analyticsRepository: analyticsRepository),
      ],
      routes: <GoRoute>[
        /// Note: we are adding `/initialize` to play nicely with Flutter's
        /// hot-reload.
        GoRoute(
          path: '/initialize',
          redirect: (context, state) {
            final bottomNavBloc = context.read<BottomNavBloc>();
            final tab = bottomNavBloc.state.tab;

            switch (tab) {
              case BottomNavTab.home:
                return '/home';

              // coverage:ignore-start
              case BottomNavTab.settings:
                return '/settings';
              // coverage:ignore-end
            }
          },
        ),
        GoRoute(
          path: '/:bottomNavTab(home|settings)',
          name: AppRoutes.launchpad.name,
          builder: (BuildContext context, GoRouterState state) {
            final bottomNavTab = state.params['bottomNavTab']!;

            final bottomNavBloc = context.read<BottomNavBloc>();
            final tab = BottomNavTab.values.byName(bottomNavTab);

            switch (tab) {
              case BottomNavTab.home:
                bottomNavBloc.add(const BottomNavEvent_ToHome());
                break;
              case BottomNavTab.settings:
                bottomNavBloc.add(const BottomNavEvent_ToSettings());
                break;
            }

            return Launchpad_Page(
              key: state.pageKey,
            );
          },
        ),
      ],
    );
