import 'package:json_annotation/json_annotation.dart';

part 'open_meteo_location.g.dart';

@JsonSerializable()
class OpenMeteoLocation {
  const OpenMeteoLocation({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory OpenMeteoLocation.fromJson(Map<String, dynamic> json) =>
      _$OpenMeteoLocationFromJson(json);

  final int id;
  final String name;
  final double latitude;
  final double longitude;
}
