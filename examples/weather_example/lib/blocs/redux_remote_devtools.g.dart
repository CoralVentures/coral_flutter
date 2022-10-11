// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'redux_remote_devtools.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DevtoolsDb _$DevtoolsDbFromJson(Map<String, dynamic> json) => DevtoolsDb(
      weatherState: json['weatherState'] == null
          ? null
          : WeatherState.fromJson(json['weatherState'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DevtoolsDbToJson(DevtoolsDb instance) =>
    <String, dynamic>{
      'weatherState': instance.weatherState,
    };
