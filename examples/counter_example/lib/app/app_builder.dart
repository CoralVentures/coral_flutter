import 'dart:async';

import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:counter_example/pages/home/home_page.dart';
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
      child: MaterialApp(
        navigatorObservers: [
          CoralAnalyticRouteObserver(
            analyticsRepository: analyticsRepository,
          )
        ],
        home: const Home_Page(),
      ),
    );
  }
}
