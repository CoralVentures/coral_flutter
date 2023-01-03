// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodosState _$TodosStateFromJson(Map<String, dynamic> json) => TodosState(
      todoItems: (json['todoItems'] as List<dynamic>)
          .map((e) => TodoItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TodosStateToJson(TodosState instance) =>
    <String, dynamic>{
      'todoItems': instance.todoItems,
    };
