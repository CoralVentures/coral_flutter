// ignore_for_file: always_use_package_imports
import 'package:coral_bloc/coral_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../bloc_type.dart';
import '../redux_remote_devtools.dart';

part 'greetings_bloc.g.dart';

part 'greetings_event.dart';
part 'greetings_state.dart';

class GreetingsBloc extends CoralBloc<GreetingsEvent, GreetingsState> {
  GreetingsBloc()
      : super(
          const GreetingsState.initialState(),
          blocType: BlocType.greetings.name,
          beforeOnEvent: remoteReduxDevtoolsOnEvent,
          beforeOnClose: remoteReduxDevtoolsOnClose,
        );

  @override
  Stream<GreetingsState> mapEventToState(
    GreetingsEvent event,
  ) async* {
    switch (event.eventType) {
      case GreetingsEvents.sayHello:
        {
          // This is the "double-yield" pattern. We send two states back-to-back
          // to the presentation layer. We want to give the UI something to
          // respond to and display a snackbar. We can use a BlocListener
          // listening to the `helloStatus`.
          yield const GreetingsState(
            helloStatus: GreetingsHelloStatus.sayHello,
          );
          yield const GreetingsState(helloStatus: GreetingsHelloStatus.idle);
        }
        break;
    }
  }
}
