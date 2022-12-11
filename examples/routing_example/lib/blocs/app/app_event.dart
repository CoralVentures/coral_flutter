part of 'app_bloc.dart';

enum AppEvents {
  toHomePage,
  toAboutPage,
}

abstract class AppEvent extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  const AppEvent({required this.eventType});

  final AppEvents eventType;

  @override
  List<Object> get props => [eventType];
}

class AppEvent_ToHomePage extends AppEvent {
  const AppEvent_ToHomePage({
    super.eventType = AppEvents.toHomePage,
  });
}

class AppEvent_ToAboutPage extends AppEvent {
  const AppEvent_ToAboutPage({
    super.eventType = AppEvents.toAboutPage,
  });
}
