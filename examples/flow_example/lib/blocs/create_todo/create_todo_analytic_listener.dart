import 'package:coral_analytics_repository/coral_analytics_repository.dart';

// ignore: always_use_package_imports
import 'create_todo_bloc.dart';

class CreateTodoEvent_AnalyticListener
    extends CoralBlocObserverAnalyticListener<CreateTodoEvent> {
  @override
  void handleEvent({
    required CreateTodoEvent event,
    required CoralAnalyticsRepository analyticsRepository,
  }) {
    switch (event.eventType) {
      case CreateTodoEvents.addTaskToTodo:
        analyticsRepository.track(eventName: 'Create TODO: Add Task');
        break;
      case CreateTodoEvents.addPriorityToTodo:
        analyticsRepository.track(eventName: 'Create TODO: Add Priority');
        break;
      case CreateTodoEvents.addAssigneeToTodo:
        analyticsRepository.track(eventName: 'Create TODO: Add Assignee');
        break;
    }
  }
}
