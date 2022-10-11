import 'dart:async';

/// The background polling status
enum BackgroundPollResultStatus {
  /// The background poll exited as expected
  ok,

  /// The background poll resulted in an error
  error,
}

/// {@template background_poll_result}
/// A class that can hold the background poll result,
/// which includes a result or an error if there
/// was one.
/// {@endtemplate}
class BackgroundPollResult<R> {
  /// {@macro background_poll_result}
  BackgroundPollResult({
    required this.status,
    this.result,
    this.error,
  });

  /// The status of the background poll result
  final BackgroundPollResultStatus status;

  /// The result, if there was one
  final R? result;

  /// The error, if there was one
  final Object? error;
}

/// {@template background_poll_rule}
/// The rule executed by [backgroundCallback].
/// {@endtemplate}
class BackgroundPollRule<R> {
  /// {@macro background_poll_rule}
  BackgroundPollRule({
    required this.interval,
    required this.backgroundCallback,
    required this.callback,
    required this.onError,
  });

  /// The interval to wait before running the backgroundCallBack again.
  final Duration interval;

  /// The callback that will be run only once. Once the completer passed into
  /// the callback completes, the backgroundCallback will also stopped being
  /// called.
  ///
  /// Note: to stop the background poll, you will need to run
  /// completer.complete(...) within this callback.
  ///
  /// if (!completer.isComplete) {
  ///   completer.completer(
  ///     BackgroundPollResult(
  ///       status: BackgroundPollResultStatus.ok
  ///       result: <some result>
  ///     ),
  ///   );
  /// }
  ///
  final void Function(Completer<BackgroundPollResult<R>>) callback;

  /// The backgroundCallBack that will be run at every interval.
  final void Function(int tick) backgroundCallback;

  /// If the background poll throws an error, this callback will be run
  final void Function(Object?) onError;
}

/// A function that will call the `callback` function within the [pollRule],
/// while continuously calling `backgroundCallback` until the [Completer]
/// passed into the `callback` completes successfully or with an error.
///
/// Exceptions caught while calling either `callback` or `backgroundCallback`
/// will immediately stop the polling and the function will return a
/// [BackgroundPollResult] with an error status and the caught exception.
Future<R?> backgroundPoll<R>(BackgroundPollRule<R> pollRule) async {
  final completer = Completer<BackgroundPollResult<R>>();

  /// Setup the background poll.
  Timer.periodic(pollRule.interval, (timer) {
    _callbackWithExceptionHandling(completer, () {
      if (!completer.isCompleted) {
        pollRule.backgroundCallback(timer.tick);
      } else {
        timer.cancel();
      }
    });
  });

  _callbackWithExceptionHandling(completer, () {
    pollRule.callback(completer);
  });

  /// Await for the completer to finish.
  final result = await completer.future;

  /// Then, depending on the result, either
  /// - return the result,
  /// - or call the onError callback
  return _handlePollResult(
    result: result,
    onError: pollRule.onError,
  );
}

/// Common callback handler with exception handling.
void _callbackWithExceptionHandling<R>(
  Completer<BackgroundPollResult<R>> completer,
  void Function() callback,
) {
  try {
    callback.call();
  } catch (e) {
    if (!completer.isCompleted) {
      completer.complete(
        BackgroundPollResult(
          status: BackgroundPollResultStatus.error,
          error: e,
        ),
      );
    }
  }
}

R? _handlePollResult<R>({
  required BackgroundPollResult<R> result,
  required void Function(Object?) onError,
}) {
  switch (result.status) {
    case BackgroundPollResultStatus.ok:
      {
        return result.result;
      }
    case BackgroundPollResultStatus.error:
      {
        onError(result.error);
      }
      break;
  }
  return null;
}
