import 'dart:async';

import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:counter_example/app/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: MaterialApp.router(
        routerConfig: appRouter(
          analyticsRepository: analyticsRepository,
        ),
      ),
    );
  }
}
