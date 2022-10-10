import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:counter_example/blocs/counter/counter_analytic_listener.dart';

List<CoralBlocObserverAnalyticListener<dynamic>> analyticListeners = [
  CounterEvent_AnalyticListener(),
];
