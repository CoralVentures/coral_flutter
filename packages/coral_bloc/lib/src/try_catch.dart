import 'package:coral_logger/coral_logger.dart';

/// Use [coralTryCatch] instead instead of the traditional try/catch pattern.
/// This will help us have a consistent handling of cubit and repository
/// methods across our Blocs. In particular, we are going to `logError` in
/// every catch.  If you want to override that, you can set `shouldLogError`
/// to false.
Future<void> coralTryCatch({
  required Future<void> Function() tryFunc,
  Future<void> Function(Object e, StackTrace stacktrace)? catchFunc,
  bool shouldLogError = true,
  bool shouldRethrow = false,
}) async {
  try {
    await tryFunc();
  } catch (e, stacktrace) {
    if (shouldLogError) {
      CoralLogger().logError(e, stacktrace: stacktrace);
    }
    if (catchFunc != null) {
      await catchFunc(e, stacktrace);
    }
    if (shouldRethrow) {
      rethrow;
    }
  }
}

/// Use [coralTryCatchStream] instead instead of the traditional try/catch
/// pattern. This will help us have a consistent handling of cubit and
/// repository methods across our Blocs. In particular, we are going to
/// `logError` in every catch.  If you want to override that, you can set
/// `shouldLogError` to false.
Stream<R> coralTryCatchStream<R>({
  required Stream<R> Function() tryFunc,
  Stream<R> Function(Object e, StackTrace stacktrace)? catchFunc,
  Stream<R> Function()? finallyFunc,
  bool shouldLogError = true,
  bool shouldRethrow = false,
}) async* {
  try {
    await for (final result in tryFunc()) {
      yield result;
    }
  } catch (e, stacktrace) {
    if (shouldLogError) {
      CoralLogger().logError(e, stacktrace: stacktrace);
    }
    if (catchFunc != null) {
      yield* catchFunc(e, stacktrace);
    }
    if (shouldRethrow) {
      rethrow;
    }
  } finally {
    if (finallyFunc != null) {
      yield* finallyFunc();
    }
  }
}
