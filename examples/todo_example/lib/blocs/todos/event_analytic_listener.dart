import 'package:coral_analytics_repository/coral_analytics_repository.dart';

// ignore: always_use_package_imports
import 'bloc.dart';

class TodosEvent_AnalyticListener
    extends CoralBlocObserverAnalyticListener<TodosEvent> {
  @override
  void handleEvent({
    required TodosEvent event,
    required CoralAnalyticsRepository analyticsRepository,
  }) {
    switch (event.eventType) {
      case TodosEvents.addTodoItem:
        analyticsRepository.track(eventName: 'TODO: Created');
        break;
      case TodosEvents.completeTodoItem:
        analyticsRepository.track(eventName: 'TODO: Completed');
        break;
      case TodosEvents.activateTodoItem:
        analyticsRepository.track(eventName: 'TODO: Reactivated');
        break;
    }
  }
}
