// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTodoState _$CreateTodoStateFromJson(Map<String, dynamic> json) =>
    CreateTodoState(
      step: $enumDecode(_$CreateTodoStepsEnumMap, json['step']),
      todoItem: TodoItem.fromJson(json['todoItem'] as Map<String, dynamic>),
      todoCreated: json['todoCreated'] as bool,
    );

Map<String, dynamic> _$CreateTodoStateToJson(CreateTodoState instance) =>
    <String, dynamic>{
      'step': _$CreateTodoStepsEnumMap[instance.step]!,
      'todoItem': instance.todoItem,
      'todoCreated': instance.todoCreated,
    };

const _$CreateTodoStepsEnumMap = {
  CreateTodoSteps.step1: 'step1',
  CreateTodoSteps.step2: 'step2',
  CreateTodoSteps.step3: 'step3',
};
