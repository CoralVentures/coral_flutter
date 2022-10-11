import 'package:coral_analytics_repository/coral_analytics_repository.dart';

// ignore: always_use_package_imports
import 'weather_bloc.dart';

class WeatherEvent_AnalyticListener
    extends CoralBlocObserverAnalyticListener<WeatherEvent> {
  @override
  void handleEvent({
    required WeatherEvent event,
    required CoralAnalyticsRepository analyticsRepository,
  }) {
    switch (event.eventType) {
      case WeatherEvents.initialize:
        // TODO: Handle this case.
        break;
    }
  }
}
