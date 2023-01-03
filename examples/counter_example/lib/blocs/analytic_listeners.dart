// ignore_for_file: always_use_package_imports
import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'counter/event_analytic_listener.dart';
// CORAL_CLI_IMPORT

List<CoralBlocObserverAnalyticListener<dynamic>> analyticListeners = [
  CounterEvent_AnalyticListener(),
  // CORAL_CLI_LISTENER
];
