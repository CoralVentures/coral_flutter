import 'package:coral_analytics_repository/coral_analytics_repository.dart';

// ignore: always_use_package_imports
import 'bloc.dart';

class AuthenticationEvent_AnalyticListener
    extends CoralBlocObserverAnalyticListener<AuthenticationEvent> {
  @override
  void handleEvent({
    required AuthenticationEvent event,
    required CoralAnalyticsRepository analyticsRepository,
  }) {
    switch (event.eventType) {
      case AuthenticationEvents.biometricAuthenticationStarted:
        analyticsRepository.track(
          eventName: 'Biometrics Authentication: Started',
        );
        break;
      case AuthenticationEvents.biometricAuthenticationFailed:
        final _event =
            event as AuthenticationEvent_BiometricAuthenticationFailed;
        analyticsRepository.track(
          eventName: 'Biometrics Authentication: Failed',
          properties: {
            'failureReason': _event.biometricsStatus.name,
          },
        );
        break;
      case AuthenticationEvents.biometricAuthenticationSucceeded:
        analyticsRepository.track(
          eventName: 'Biometrics Authentication: Succeeded',
        );
        break;
    }
  }
}
