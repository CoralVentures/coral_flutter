// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticationState _$AuthenticationStateFromJson(Map<String, dynamic> json) =>
    AuthenticationState(
      biometricsStatus:
          $enumDecode(_$CoralBiometricsStatusEnumMap, json['biometricsStatus']),
    );

Map<String, dynamic> _$AuthenticationStateToJson(
        AuthenticationState instance) =>
    <String, dynamic>{
      'biometricsStatus':
          _$CoralBiometricsStatusEnumMap[instance.biometricsStatus]!,
    };

const _$CoralBiometricsStatusEnumMap = {
  CoralBiometricsStatus.unknown: 'unknown',
  CoralBiometricsStatus.unsupported: 'unsupported',
  CoralBiometricsStatus.supportedButNotSetUp: 'supportedButNotSetUp',
  CoralBiometricsStatus.authenticationFailed: 'authenticationFailed',
  CoralBiometricsStatus.authenticationPassed: 'authenticationPassed',
};
