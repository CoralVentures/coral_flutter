import 'package:coral_analytics_repository/coral_analytics_repository.dart';

// ignore: always_use_package_imports
import 'bloc.dart';

class QuoteEvent_AnalyticListener
    extends CoralBlocObserverAnalyticListener<QuoteEvent> {
  @override
  void handleEvent({
    required QuoteEvent event,
    required CoralAnalyticsRepository analyticsRepository,
  }) {
    switch (event.eventType) {
      case QuoteEvents.randomQuote:
        analyticsRepository.track(eventName: 'Quote: Get Random Quote');
        break;
    }
  }
}
