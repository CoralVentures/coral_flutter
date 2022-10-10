import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:coral_bloc/src/typedefs.dart';

abstract class CoralCubit<State> extends Cubit<State> {
  CoralCubit(
    super.initialState, {
    required this.blocType,
    this.beforeOnChange,
    this.beforeOnClose,
  });

  final String blocType;
  final CoralBlocOnChange<String>? beforeOnChange;
  final CoralBlocOnClose<String>? beforeOnClose;

  @override
  void onChange(Change<State> change) {
    beforeOnChange?.call(
      blocType: blocType,
      state: state,
      event: this,
    );

    super.onChange(change);
  }

  @override
  Future<void> close() async {
    beforeOnClose?.call(blocType: blocType);

    await super.close();
  }
}
