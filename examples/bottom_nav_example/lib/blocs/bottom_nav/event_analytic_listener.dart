import 'package:coral_analytics_repository/coral_analytics_repository.dart';

// ignore: always_use_package_imports
import 'bloc.dart';

class BottomNavEvent_AnalyticListener
    extends CoralBlocObserverAnalyticListener<BottomNavEvent> {
  @override
  void handleEvent({
    required BottomNavEvent event,
    required CoralAnalyticsRepository analyticsRepository,
  }) {
    switch (event.eventType) {
      case BottomNavEvents.toHome:
        analyticsRepository.screen(screenName: 'Home');
        break;
      case BottomNavEvents.toSettings:
        analyticsRepository.screen(screenName: 'Settings');
        break;
    }
  }
}
