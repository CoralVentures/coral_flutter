// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'redux_remote_devtools.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DevtoolsDb _$DevtoolsDbFromJson(Map<String, dynamic> json) => DevtoolsDb(
      todosState: json['todosState'] == null
          ? null
          : TodosState.fromJson(json['todosState'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DevtoolsDbToJson(DevtoolsDb instance) =>
    <String, dynamic>{
      'todosState': instance.todosState,
    };
