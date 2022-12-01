// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_todo_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTodoState _$CreateTodoStateFromJson(Map<String, dynamic> json) =>
    CreateTodoState(
      todoItem: TodoItem.fromJson(json['todoItem'] as Map<String, dynamic>),
      todoCreated: json['todoCreated'] as bool,
    );

Map<String, dynamic> _$CreateTodoStateToJson(CreateTodoState instance) =>
    <String, dynamic>{
      'todoItem': instance.todoItem,
      'todoCreated': instance.todoCreated,
    };
