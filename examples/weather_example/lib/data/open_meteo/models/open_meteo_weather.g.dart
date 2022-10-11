// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_meteo_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenMeteoWeather _$OpenMeteoWeatherFromJson(Map<String, dynamic> json) =>
    OpenMeteoWeather(
      temperature: (json['temperature'] as num).toDouble(),
      weatherCode: (json['weathercode'] as num).toDouble(),
    );

Map<String, dynamic> _$OpenMeteoWeatherToJson(OpenMeteoWeather instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'weathercode': instance.weatherCode,
    };
