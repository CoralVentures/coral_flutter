// ignore_for_file: always_use_package_imports
import 'package:coral_bloc/coral_bloc.dart';
import 'package:data_layer_example/data_providers/quotable/quotable_models.dart';
import 'package:data_layer_example/repositories/quote/quote_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../bloc_type.dart';
import '../redux_remote_devtools.dart';

part 'quote_bloc.g.dart';

part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends CoralBloc<QuoteEvent, QuoteState> {
  QuoteBloc({
    required this.quoteRepository,
  }) : super(
          const QuoteState.initialState(),
          blocType: BlocType.quote.name,
          beforeOnEvent: remoteReduxDevtoolsOnEvent,
          beforeOnClose: remoteReduxDevtoolsOnClose,
        );

  final QuoteRepository quoteRepository;

  @override
  Stream<QuoteState> mapEventToState(QuoteEvent event) async* {
    switch (event.eventType) {
      case QuoteEvents.randomQuote:
        {
          // We use `coralTryCatchStream` instead of a traditional try/catch
          // because it is easy to wire this up incorrectly with streams and we
          // also log the error by default.
          yield* coralTryCatchStream<QuoteState>(
            tryFunc: () async* {
              yield const QuoteState(
                quote: null,
                quoteStatus: QuoteStatus.inProgress,
              );

              final quote = await quoteRepository.getRandomQuote();

              yield state.copyWith(
                quote: quote,
                quoteStatus: QuoteStatus.idle,
              );
            },
            // Between the `catchFunc` and the `finallyFunc` we have implemented
            // the "double-yield" pattern for the error case. This gives the UI
            // an opportunity to display an error to the user.
            catchFunc: (e, stacktrace) async* {
              yield const QuoteState(
                quote: null,
                quoteStatus: QuoteStatus.error,
              );
            },
            finallyFunc: () async* {
              yield state.copyWith(
                quoteStatus: QuoteStatus.idle,
              );
            },
          );
        }
        break;
    }
  }
}
