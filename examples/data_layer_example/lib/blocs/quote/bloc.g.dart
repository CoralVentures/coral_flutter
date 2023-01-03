// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteState _$QuoteStateFromJson(Map<String, dynamic> json) => QuoteState(
      quote: json['quote'] == null
          ? null
          : QuotableQuote.fromJson(json['quote'] as Map<String, dynamic>),
      quoteStatus: $enumDecode(_$QuoteStatusEnumMap, json['quoteStatus']),
    );

Map<String, dynamic> _$QuoteStateToJson(QuoteState instance) =>
    <String, dynamic>{
      'quote': instance.quote,
      'quoteStatus': _$QuoteStatusEnumMap[instance.quoteStatus]!,
    };

const _$QuoteStatusEnumMap = {
  QuoteStatus.idle: 'idle',
  QuoteStatus.inProgress: 'inProgress',
  QuoteStatus.error: 'error',
};
