// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoItem _$TodoItemFromJson(Map<String, dynamic> json) => TodoItem(
      id: json['id'] as String,
      item: json['item'] as String,
      status: $enumDecode(_$TodoItemStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$TodoItemToJson(TodoItem instance) => <String, dynamic>{
      'id': instance.id,
      'item': instance.item,
      'status': _$TodoItemStatusEnumMap[instance.status]!,
    };

const _$TodoItemStatusEnumMap = {
  TodoItemStatus.active: 'active',
  TodoItemStatus.completed: 'completed',
};
