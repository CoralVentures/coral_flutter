import 'package:json_annotation/json_annotation.dart';

part 'open_meteo_weather.g.dart';

@JsonSerializable()
class OpenMeteoWeather {
  const OpenMeteoWeather({
    required this.temperature,
    required this.weatherCode,
  });

  factory OpenMeteoWeather.fromJson(Map<String, dynamic> json) =>
      _$OpenMeteoWeatherFromJson(json);

  final double temperature;
  @JsonKey(name: 'weathercode')
  final double weatherCode;
}
