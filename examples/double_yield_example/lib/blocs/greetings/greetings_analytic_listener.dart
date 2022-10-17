import 'package:coral_analytics_repository/coral_analytics_repository.dart';

// ignore: always_use_package_imports
import 'greetings_bloc.dart';

class GreetingsEvent_AnalyticListener
    extends CoralBlocObserverAnalyticListener<GreetingsEvent> {
  @override
  void handleEvent({
    required GreetingsEvent event,
    required CoralAnalyticsRepository analyticsRepository,
  }) {
    switch (event.eventType) {
      case GreetingsEvents.sayHello:
        break; // no-op
    }
  }
}
