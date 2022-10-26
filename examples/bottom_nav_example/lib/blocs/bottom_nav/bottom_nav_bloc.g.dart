// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bottom_nav_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BottomNavState _$BottomNavStateFromJson(Map<String, dynamic> json) =>
    BottomNavState(
      tab: $enumDecode(_$BottomNavTabEnumMap, json['tab']),
    );

Map<String, dynamic> _$BottomNavStateToJson(BottomNavState instance) =>
    <String, dynamic>{
      'tab': _$BottomNavTabEnumMap[instance.tab]!,
    };

const _$BottomNavTabEnumMap = {
  BottomNavTab.home: 'home',
  BottomNavTab.settings: 'settings',
};
