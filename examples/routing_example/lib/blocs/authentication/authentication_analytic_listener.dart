import 'package:coral_analytics_repository/coral_analytics_repository.dart';

// ignore: always_use_package_imports
import 'authentication_bloc.dart';

class AuthenticationEvent_AnalyticListener
    extends CoralBlocObserverAnalyticListener<AuthenticationEvent> {
  @override
  void handleEvent({
    required AuthenticationEvent event,
    required CoralAnalyticsRepository analyticsRepository,
  }) {
    switch (event.eventType) {
      case AuthenticationEvents.login:
        analyticsRepository.track(eventName: 'Login Attempted');
        break;
      case AuthenticationEvents.loginSucceeded:
        analyticsRepository.track(eventName: 'Login Succeeded');
        break;
      case AuthenticationEvents.loginFailed:
        analyticsRepository.track(eventName: 'Login Failed');
        break;

      case AuthenticationEvents.logout:
        analyticsRepository.track(eventName: 'Logout');
        break;
    }
  }
}
