// ignore_for_file: always_use_package_imports
import 'package:coral_bloc/coral_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../bloc_type.dart';
import '../redux_remote_devtools.dart';

part 'bloc.g.dart';
part 'event.dart';
part 'state.dart';

class CounterBloc extends CoralBloc<CounterEvent, CounterState> {
  CounterBloc()
      : super(
          const CounterState.initialState(),
          blocType: BlocType.counter.name,
          beforeOnClose: remoteReduxDevtoolsOnClose,
          beforeOnEvent: remoteReduxDevtoolsOnEvent,
        );

  @override
  Stream<CounterState> mapEventToState(
    CounterEvent event,
  ) async* {
    switch (event.eventType) {
      case CounterEvents.increment:
        yield CounterState(count: state.count + 1);
        break;

      case CounterEvents.decrement:
        yield CounterState(count: state.count - 1);
        break;
    }
  }
}
