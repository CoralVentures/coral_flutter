import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quotable_models.g.dart';

@JsonSerializable()
class QuotableQuote extends Equatable {
  const QuotableQuote({
    required this.id,
    required this.content,
    this.author,
    this.authorSlug,
    this.tags,
  });
  // coverage:ignore-start
  factory QuotableQuote.fromJson(Map<String, dynamic> json) =>
      _$QuotableQuoteFromJson(json);

  @JsonKey(name: '_id')
  final String id;
  final String content;
  final String? author;
  final String? authorSlug;
  final List<String>? tags;

  Map<String, dynamic> toJson() => _$QuotableQuoteToJson(this);
  // coverage:ignore-end

  @override
  List<Object?> get props => [
        id,
        content,
        author,
        authorSlug,
        tags,
      ];
}
