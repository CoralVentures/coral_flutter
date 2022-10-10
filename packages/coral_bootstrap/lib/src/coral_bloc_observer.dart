import 'package:bloc/bloc.dart';
import 'package:coral_logger/coral_logger.dart';

class CoralBlocObserver extends BlocObserver {
  CoralBlocObserver({
    this.onEventCallback,
  });

  final void Function(Object?)? onEventCallback;

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    CoralLogger().logMessage(
      change.toString(),
      extras: {'Bloc': bloc.runtimeType.toString()},
    );
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);

    CoralLogger().logMessage(
      event.toString(),
      extras: {
        'Bloc': bloc.runtimeType.toString(),
      },
    );

    onEventCallback?.call(event);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    CoralLogger().logError(
      '[${bloc.runtimeType}] $error',
      stacktrace: stackTrace,
    );

    super.onError(bloc, error, stackTrace);
  }
}
