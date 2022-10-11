// ignore_for_file: sort_constructors_first

part of 'weather_bloc.dart';

@JsonSerializable()
class WeatherState extends Equatable {
  const WeatherState();

  const WeatherState.initialState();

  // coverage:ignore-start
  factory WeatherState.fromJson(Map<String, dynamic> json) =>
      _$WeatherStateFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherStateToJson(this);
  // coverage:ignore-end

  @override
  List<Object?> get props => [];
}
