// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'redux_remote_devtools.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DevtoolsDb _$DevtoolsDbFromJson(Map<String, dynamic> json) => DevtoolsDb(
      createTodoState: json['createTodoState'] == null
          ? null
          : CreateTodoState.fromJson(
              json['createTodoState'] as Map<String, dynamic>),
      todosState: json['todosState'] == null
          ? null
          : TodosState.fromJson(json['todosState'] as Map<String, dynamic>),
      appState: json['appState'] == null
          ? null
          : AppState.fromJson(json['appState'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DevtoolsDbToJson(DevtoolsDb instance) =>
    <String, dynamic>{
      'createTodoState': instance.createTodoState,
      'todosState': instance.todosState,
      'appState': instance.appState,
    };
