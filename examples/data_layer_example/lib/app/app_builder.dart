import 'dart:async';

import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:data_layer_example/app/app_router.dart';
import 'package:data_layer_example/l10n/l10n.dart';
import 'package:data_layer_example/repositories/quote/quote_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

FutureOr<Widget> appBuilder({
  CoralAnalyticsRepository? analyticsRepository,
  required QuoteRepository quoteRepository,
}) {
  return App(
    analyticsRepository: analyticsRepository,
    quoteRepository: quoteRepository,
  );
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.analyticsRepository,
    required this.quoteRepository,
  });

  final CoralAnalyticsRepository? analyticsRepository;
  final QuoteRepository quoteRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: analyticsRepository),
        RepositoryProvider.value(value: quoteRepository),
      ],
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
    );
  }
}
