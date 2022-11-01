import 'dart:async';

import 'package:biometrics_example/app/app_router.dart';
import 'package:biometrics_example/blocs/authentication/authentication_bloc.dart';
import 'package:biometrics_example/l10n/l10n.dart';
import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:coral_biometrics_repository/coral_biometrics_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
  const App({
    super.key,
    required this.analyticsRepository,
    required this.biometricsRepository,
  });

  final CoralAnalyticsRepository? analyticsRepository;
  final CoralBiometricsRepository biometricsRepository;

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
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          biometricsRepository: context.read<CoralBiometricsRepository>(),
        ),
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
