part of 'bloc.dart';

enum QuoteEvents {
  randomQuote,
}

abstract class QuoteEvent extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  const QuoteEvent(this.eventType);

  final QuoteEvents eventType;

  @override
  List<Object> get props => [eventType];
}

class QuoteEvent_RandomQuote extends QuoteEvent {
  const QuoteEvent_RandomQuote() : super(QuoteEvents.randomQuote);
}
