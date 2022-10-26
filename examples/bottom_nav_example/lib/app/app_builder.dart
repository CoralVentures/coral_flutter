import 'dart:async';

import 'package:bottom_nav_example/app/app_router.dart';
import 'package:bottom_nav_example/blocs/bottom_nav/bottom_nav_bloc.dart';
import 'package:bottom_nav_example/l10n/l10n.dart';
import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

FutureOr<Widget> appBuilder({
  CoralAnalyticsRepository? analyticsRepository,
}) {
  return App(analyticsRepository: analyticsRepository);
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.analyticsRepository,
  });

  final CoralAnalyticsRepository? analyticsRepository;

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
          routerConfig: appRouter(
            analyticsRepository: analyticsRepository,
          ),
        ),
      ),
    );
  }
}
