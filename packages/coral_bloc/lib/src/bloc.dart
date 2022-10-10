import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:coral_bloc/src/typedefs.dart';

abstract class CoralBloc<Event, State> extends Bloc<Event, State> {
  CoralBloc(
    super.state, {
    required this.blocType,
    EventTransformer<Event>? eventTransformerOverride,
    this.beforeOnEvent,
    this.beforeOnClose,
  }) {
    on<Event>(
      _onEvent,
      transformer: eventTransformerOverride ?? sequential<Event>(),
    );
  }

  final String blocType;
  final CoralBlocOnEvent<String>? beforeOnEvent;
  final CoralBlocOnClose<String>? beforeOnClose;

  Stream<State> mapEventToState(Event event);

  Future<void> _onEvent(Event event, Emitter<State> emit) async {
    await mapEventToState(event).forEach((state) {
      beforeOnEvent?.call(
        blocType: blocType,
        state: state,
        event: event,
      );

      /// Emit state for Bloc
      emit(state);
    });
  }

  EventTransformer<E> sequential<E>() {
    return (events, mapper) => events.asyncExpand(mapper);
  }

  @override
  Future<void> close() async {
    beforeOnClose?.call(blocType: blocType);

    await super.close();
  }
}
