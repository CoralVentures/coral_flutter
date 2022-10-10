import 'package:coral_analytics_repository/coral_analytics_repository.dart';

void Function(Object?) createAnalyticsOnEventCallback({
  List<CoralBlocObserverAnalyticListener<dynamic>>? analyticListeners,
  CoralAnalyticsRepository? analyticsRepository,
}) {
  void handleEvent(Object? event) {
    if (analyticsRepository != null &&
        analyticListeners != null &&
        analyticListeners.isNotEmpty &&
        event != null) {
      for (final listener in analyticListeners) {
        if (listener.shouldHandleEvent(event)) {
          listener.handleEvent(
            event: event,
            analyticsRepository: analyticsRepository,
          );
        }
      }
    }
  }

  return handleEvent;
}

/// A [CoralBlocObserverAnalyticListener] listens for events that are observed
/// by the `CoralBlocObserver`.
///
/// More specifically, this class will listen for events, determine if it wants
/// to handle them, and then handle them.  This class will handle events by
/// making use of the [CoralAnalyticsRepository] and send information to
/// Segment.
abstract class CoralBlocObserverAnalyticListener<T> {
  void handleEvent({
    required T event,
    required CoralAnalyticsRepository analyticsRepository,
  });

  bool shouldHandleEvent(Object event) {
    return event is T;
  }
}
