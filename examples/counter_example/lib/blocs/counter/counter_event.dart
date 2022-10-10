part of 'counter_bloc.dart';

enum CounterEvents {
  increment,
  decrement,
}

abstract class CounterEvent extends Equatable {
  const CounterEvent(this.eventType);

  final CounterEvents eventType;

  @override
  List<Object> get props => [eventType];
}

class CounterEvent_Increment extends CounterEvent {
  const CounterEvent_Increment() : super(CounterEvents.increment);
}

class CounterEvent_Decrement extends CounterEvent {
  const CounterEvent_Decrement() : super(CounterEvents.decrement);
}
