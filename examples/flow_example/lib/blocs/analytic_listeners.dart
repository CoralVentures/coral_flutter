// ignore_for_file: always_use_package_imports
import 'package:coral_analytics_repository/coral_analytics_repository.dart';

import 'app/event_analytic_listener.dart';
import 'create_todo/event_analytic_listener.dart';
import 'todos/event_analytic_listener.dart';
// CORAL_CLI_IMPORT

List<CoralBlocObserverAnalyticListener<dynamic>> analyticListeners = [
  CreateTodoEvent_AnalyticListener(),
  TodosEvent_AnalyticListener(),
  AppEvent_AnalyticListener(),
  // CORAL_CLI_LISTENER
];
