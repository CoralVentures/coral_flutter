part of 'bloc.dart';

enum BottomNavEvents {
  toHome,
  toSettings,
}

abstract class BottomNavEvent extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  const BottomNavEvent(this.eventType);

  final BottomNavEvents eventType;

  @override
  List<Object> get props => [eventType];
}

class BottomNavEvent_ToHome extends BottomNavEvent {
  const BottomNavEvent_ToHome() : super(BottomNavEvents.toHome);
}

class BottomNavEvent_ToSettings extends BottomNavEvent {
  const BottomNavEvent_ToSettings() : super(BottomNavEvents.toSettings);
}
