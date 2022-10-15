// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticationState _$AuthenticationStateFromJson(Map<String, dynamic> json) =>
    AuthenticationState(
      status: $enumDecode(_$AuthenticationStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$AuthenticationStateToJson(
        AuthenticationState instance) =>
    <String, dynamic>{
      'status': _$AuthenticationStatusEnumMap[instance.status]!,
    };

const _$AuthenticationStatusEnumMap = {
  AuthenticationStatus.none: 'none',
  AuthenticationStatus.inProgress: 'inProgress',
  AuthenticationStatus.authenticated: 'authenticated',
  AuthenticationStatus.failed: 'failed',
};
