part of 'weather_bloc.dart';

enum WeatherEvents {
  initialize,
}

abstract class WeatherEvent extends Equatable {
  const WeatherEvent(this.eventType);

  final WeatherEvents eventType;

  @override
  List<Object> get props => [eventType];
}

class WeatherEvent_Initialize extends WeatherEvent {
  const WeatherEvent_Initialize() : super(WeatherEvents.initialize);
}
