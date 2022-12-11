// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'redux_remote_devtools.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DevtoolsDb _$DevtoolsDbFromJson(Map<String, dynamic> json) => DevtoolsDb(
      counterState: json['counterState'] == null
          ? null
          : CounterState.fromJson(json['counterState'] as Map<String, dynamic>),
      appState: json['appState'] == null
          ? null
          : AppState.fromJson(json['appState'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DevtoolsDbToJson(DevtoolsDb instance) =>
    <String, dynamic>{
      'counterState': instance.counterState,
      'appState': instance.appState,
    };
