part of 'counter_bloc.dart';

enum CounterEvents {
  increment,
  decrement,
}

abstract class CounterEvent extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  CounterEvent(this.eventType);

  final CounterEvents eventType;

  @override
  List<Object> get props => [eventType];
}

class CounterEvent_Increment extends CounterEvent {
  CounterEvent_Increment() : super(CounterEvents.increment);
}

class CounterEvent_Decrement extends CounterEvent {
  CounterEvent_Decrement() : super(CounterEvents.decrement);
}
