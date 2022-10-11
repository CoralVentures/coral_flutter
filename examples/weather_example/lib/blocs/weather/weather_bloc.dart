// ignore_for_file: always_use_package_imports
import 'package:coral_bloc/coral_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../bloc_type.dart';
import '../redux_remote_devtools.dart';

part 'weather_bloc.g.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends CoralBloc<WeatherEvent, WeatherState> {
  WeatherBloc()
      : super(
          const WeatherState.initialState(),
          blocType: BlocType.weather.name,
          beforeOnEvent: remoteReduxDevtoolsOnEvent,
          beforeOnClose: remoteReduxDevtoolsOnClose,
        );

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    switch (event.eventType) {
      case WeatherEvents.initialize:
        // TODO: Handle this case.
        break;
    }
  }
}
