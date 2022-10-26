// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'redux_remote_devtools.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DevtoolsDb _$DevtoolsDbFromJson(Map<String, dynamic> json) => DevtoolsDb(
      bottomNavState: json['bottomNavState'] == null
          ? null
          : BottomNavState.fromJson(
              json['bottomNavState'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DevtoolsDbToJson(DevtoolsDb instance) =>
    <String, dynamic>{
      'bottomNavState': instance.bottomNavState,
    };
