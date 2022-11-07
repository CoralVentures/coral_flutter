import 'dart:async';

import 'package:bottom_nav_example/blocs/bottom_nav/bottom_nav_bloc.dart';
import 'package:bottom_nav_example/l10n/l10n.dart';
import 'package:bottom_nav_example/pages/launchpad/launchpad_page.dart';
import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

enum AppRoutes { launchpad }

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
          initialLocation: '/home',
          observers: [
            CoralAnalyticRouteObserver(
              analyticsRepository: analyticsRepository,
            ),
          ],
          routes: <GoRoute>[
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

  final CoralAnalyticsRepository? analyticsRepository;
  final GoRouter _routerConfig;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: analyticsRepository,
      child: BlocProvider(
        create: (contextP) => BottomNavBloc(),
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
