// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_meteo_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenMeteoLocation _$OpenMeteoLocationFromJson(Map<String, dynamic> json) =>
    OpenMeteoLocation(
      id: json['id'] as int,
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$OpenMeteoLocationToJson(OpenMeteoLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
