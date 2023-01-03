// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuotableQuote _$QuotableQuoteFromJson(Map<String, dynamic> json) =>
    QuotableQuote(
      id: json['_id'] as String,
      content: json['content'] as String,
      author: json['author'] as String?,
      authorSlug: json['authorSlug'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$QuotableQuoteToJson(QuotableQuote instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'content': instance.content,
      'author': instance.author,
      'authorSlug': instance.authorSlug,
      'tags': instance.tags,
    };
