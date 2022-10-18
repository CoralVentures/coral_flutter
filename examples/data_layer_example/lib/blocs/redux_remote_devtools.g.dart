// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'redux_remote_devtools.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DevtoolsDb _$DevtoolsDbFromJson(Map<String, dynamic> json) => DevtoolsDb(
      quoteState: json['quoteState'] == null
          ? null
          : QuoteState.fromJson(json['quoteState'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DevtoolsDbToJson(DevtoolsDb instance) =>
    <String, dynamic>{
      'quoteState': instance.quoteState,
    };
