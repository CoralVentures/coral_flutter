// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) => AppState(
      flow: $enumDecode(_$AppFlowsEnumMap, json['flow']),
    );

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'flow': _$AppFlowsEnumMap[instance.flow]!,
    };

const _$AppFlowsEnumMap = {
  AppFlows.home: 'home',
  AppFlows.createTodo: 'createTodo',
};
