part of 'bloc.dart';

enum GreetingsEvents { sayHello }

abstract class GreetingsEvent extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  const GreetingsEvent(this.eventType);

  final GreetingsEvents eventType;

  @override
  List<Object> get props => [eventType];
}

class GreetingsEvent_SayHello extends GreetingsEvent {
  const GreetingsEvent_SayHello() : super(GreetingsEvents.sayHello);
}
