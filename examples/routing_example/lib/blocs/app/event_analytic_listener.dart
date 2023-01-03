import 'package:coral_analytics_repository/coral_analytics_repository.dart';

// ignore: always_use_package_imports
import 'bloc.dart';

class AppEvent_AnalyticListener
    extends CoralBlocObserverAnalyticListener<AppEvent> {
  @override
  void handleEvent({
    required AppEvent event,
    required CoralAnalyticsRepository analyticsRepository,
  }) {
    switch (event.eventType) {
      case AppEvents.toHomePage:
      case AppEvents.toAboutPage:
        // no-op
        break;
    }
  }
}
