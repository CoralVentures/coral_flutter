import 'package:coral_analytics_repository/coral_analytics_repository.dart';

// ignore: always_use_package_imports
import 'todos_bloc.dart';

class TodosEvent_AnalyticListener
    extends CoralBlocObserverAnalyticListener<TodosEvent> {
  @override
  void handleEvent({
    required TodosEvent event,
    required CoralAnalyticsRepository analyticsRepository,
  }) {
    switch (event.eventType) {
      case TodosEvents.addTodo:
        analyticsRepository.track(eventName: 'Todos: Item Created');
        break;
    }
  }
}
