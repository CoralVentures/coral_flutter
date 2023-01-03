// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GreetingsState _$GreetingsStateFromJson(Map<String, dynamic> json) =>
    GreetingsState(
      helloStatus:
          $enumDecode(_$GreetingsHelloStatusEnumMap, json['helloStatus']),
    );

Map<String, dynamic> _$GreetingsStateToJson(GreetingsState instance) =>
    <String, dynamic>{
      'helloStatus': _$GreetingsHelloStatusEnumMap[instance.helloStatus]!,
    };

const _$GreetingsHelloStatusEnumMap = {
  GreetingsHelloStatus.idle: 'idle',
  GreetingsHelloStatus.sayHello: 'sayHello',
};
