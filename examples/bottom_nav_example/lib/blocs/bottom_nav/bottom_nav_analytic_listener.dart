import 'package:coral_analytics_repository/coral_analytics_repository.dart';

// ignore: always_use_package_imports
import 'bottom_nav_bloc.dart';

class BottomNavEvent_AnalyticListener
    extends CoralBlocObserverAnalyticListener<BottomNavEvent> {
  @override
  void handleEvent({
    required BottomNavEvent event,
    required CoralAnalyticsRepository analyticsRepository,
  }) {
    switch (event.eventType) {
      case BottomNavEvents.toHome:
        analyticsRepository.screen(screenName: BottomNavTab.home.name);
        break;
      case BottomNavEvents.toSettings:
        analyticsRepository.screen(screenName: BottomNavTab.settings.name);
        break;
    }
  }
}
