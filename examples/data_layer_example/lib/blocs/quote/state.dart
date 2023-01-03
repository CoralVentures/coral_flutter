// ignore_for_file: sort_constructors_first

part of 'bloc.dart';

enum QuoteStatus { idle, inProgress, error }

@JsonSerializable()
class QuoteState extends Equatable {
  const QuoteState({
    required this.quote,
    required this.quoteStatus,
  });

  const QuoteState.initialState()
      : quote = null,
        quoteStatus = QuoteStatus.idle;

  final QuotableQuote? quote;
  final QuoteStatus quoteStatus;

  QuoteState copyWith({
    QuotableQuote? quote,
    required QuoteStatus quoteStatus,
  }) =>
      QuoteState(
        quote: quote ?? this.quote,
        quoteStatus: quoteStatus,
      );

  // coverage:ignore-start
  factory QuoteState.fromJson(Map<String, dynamic> json) =>
      _$QuoteStateFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteStateToJson(this);
  // coverage:ignore-end

  @override
  List<Object?> get props => [quote, quoteStatus];
}
