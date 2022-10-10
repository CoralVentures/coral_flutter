import 'package:coral_analytics_repository/coral_analytics_repository.dart';

// ignore: always_use_package_imports
import 'counter_bloc.dart';

class CounterEventAnalyticListener
    extends CoralBlocObserverAnalyticListener<CounterEvent> {
  @override
  void handleEvent({
    required CounterEvent event,
    required CoralAnalyticsRepository analyticsRepository,
  }) {
    switch (event.eventType) {
      case CounterEvents.increment:
        analyticsRepository.track(eventName: 'Counter: Increment');
        break;
      case CounterEvents.decrement:
        analyticsRepository.track(eventName: 'Counter: Decrement');
        break;
    }
  }
}
