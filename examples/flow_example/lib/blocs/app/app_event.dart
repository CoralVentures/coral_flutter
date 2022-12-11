part of 'app_bloc.dart';

enum AppEvents {
  toHomeFlow,
  toCreateTodoFlow,
}

abstract class AppEvent extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  const AppEvent({required this.eventType});

  final AppEvents eventType;

  @override
  List<Object> get props => [eventType];
}

class AppEvent_ToHomeFlow extends AppEvent {
  const AppEvent_ToHomeFlow({
    super.eventType = AppEvents.toHomeFlow,
  });
}

class AppEvent_ToCreateTodoFlow extends AppEvent {
  const AppEvent_ToCreateTodoFlow({
    super.eventType = AppEvents.toCreateTodoFlow,
  });
}
