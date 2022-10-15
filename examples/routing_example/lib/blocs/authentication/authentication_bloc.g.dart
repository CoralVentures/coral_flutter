// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticationState _$AuthenticationStateFromJson(Map<String, dynamic> json) =>
    AuthenticationState(
      isAuthenticated: json['isAuthenticated'] as bool,
    );

Map<String, dynamic> _$AuthenticationStateToJson(
        AuthenticationState instance) =>
    <String, dynamic>{
      'isAuthenticated': instance.isAuthenticated,
    };
