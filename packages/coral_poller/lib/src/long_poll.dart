import 'dart:async';

/// The long polling status
enum LongPollResultStatus {
  /// The long poll exited as expected
  ok,

  /// The long poll resulted in an error
  error,

  /// The long poll timed out
  timeout,
}

/// {@template long_poll_result}
/// A class that can hold the long poll result,
/// which includes a result or an error if there
/// was one.
/// {@endtemplate}
class LongPollResult<R> {
  /// {@macro poll_result}
  LongPollResult({
    required this.status,
    this.result,
    this.error,
  });

  /// The status of the long poll result
  final LongPollResultStatus status;

  /// The result, if there was one
  final R? result;

  /// The error, if there was one
  final Object? error;
}

/// {@template long_poll_rule}
///
/// {@endtemplate}
class LongPollRule<R> {
  /// {@macro long_poll_rule}
  LongPollRule({
    required this.interval,
    required this.callback,
    this.runCallbackOnStart = true,
    required this.timeout,
    required this.onTimeout,
    required this.onError,
  });

  /// The interval to wait before running the callback again
  final Duration interval;

  /// The callback that will be run at every interval
  /// Note: to stop the long poll, you will need to run completer.complete(...)
  ///
  /// if (!completer.isComplete) {
  ///   completer.completer(
  ///     LongPollResult(
  ///       status: LongPollResultStatus.ok
  ///       result: <some result>
  ///     ),
  ///   );
  /// }
  ///
  final Future<void> Function(Completer<LongPollResult<R>>) callback;

  /// Whether or not to run the callback immediately
  /// Defaults to true
  final bool runCallbackOnStart;

  /// The timeout to wait before cancelling the long poll
  /// all together
  final Duration timeout;

  /// If the long poll times out, this callback will be run
  final void Function() onTimeout;

  /// The the long poll throws an error, this callback will be run
  final void Function(Object?) onError;
}

/// A function that will continuously run a callback at a specified interval
/// until it either completes, times out, or throws an error.
Future<R?> longPoll<R>(LongPollRule<R> pollRule) async {
  final completer = Completer<LongPollResult<R>>();
  LongPollResult<R> result;

  /// Setup a timeout that will cancel the long poll
  Timer(pollRule.timeout, () {
    if (!completer.isCompleted) {
      completer
          .complete(LongPollResult<R>(status: LongPollResultStatus.timeout));
    }
  });

  /// immediately run the callback
  if (pollRule.runCallbackOnStart) {
    await _runCallback(completer: completer, pollRule: pollRule);
  }

  /// Then continue to run the callback at the specified interval
  await Future.doWhile(() async {
    await Future.delayed(pollRule.interval, () async {
      await _runCallback(completer: completer, pollRule: pollRule);
    });
    return !completer.isCompleted;
  });

  /// Await for the completer to finish
  result = await completer.future;

  /// Then, depending on the result, either
  /// - return the result,
  /// - call the onTimeout callback,
  /// - or call the onError callback
  return _handlePollResult(
    result: result,
    onTimeout: pollRule.onTimeout,
    onError: pollRule.onError,
  );
}

Future<void> _runCallback<R>({
  required Completer<LongPollResult<R>> completer,
  required LongPollRule<R> pollRule,
}) async {
  if (!completer.isCompleted) {
    await pollRule.callback(completer).catchError(
      (Object? e) {
        completer.complete(
          LongPollResult(status: LongPollResultStatus.error, error: e),
        );
      },
    );
  }
}

R? _handlePollResult<R>({
  required LongPollResult<R> result,
  required void Function() onTimeout,
  required void Function(Object?) onError,
}) {
  switch (result.status) {
    case LongPollResultStatus.ok:
      {
        return result.result;
      }
    case LongPollResultStatus.timeout:
      {
        onTimeout();
      }
      break;
    case LongPollResultStatus.error:
      {
        onError(result.error);
      }
      break;
  }
  return null;
}
