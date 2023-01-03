// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) => AppState(
      route: $enumDecode(_$AppRoutesEnumMap, json['route']),
    );

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'route': _$AppRoutesEnumMap[instance.route]!,
    };

const _$AppRoutesEnumMap = {
  AppRoutes.home: 'home',
  AppRoutes.about: 'about',
};
