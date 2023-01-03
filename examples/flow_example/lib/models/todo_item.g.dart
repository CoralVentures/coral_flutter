// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoItem _$TodoItemFromJson(Map<String, dynamic> json) => TodoItem(
      task: json['task'] as String?,
      priority: json['priority'] as String?,
      assignee: json['assignee'] as String?,
    );

Map<String, dynamic> _$TodoItemToJson(TodoItem instance) => <String, dynamic>{
      'task': instance.task,
      'priority': instance.priority,
      'assignee': instance.assignee,
    };
