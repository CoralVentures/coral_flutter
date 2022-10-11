import 'package:coral_poller/src/background_poll.dart';
import 'package:test/test.dart';

void main() {
  group('backgroundPoll', () {
    test('calls completes ok with result', () async {
      final actual = await backgroundPoll<String>(
        BackgroundPollRule(
          interval: const Duration(milliseconds: 100),
          backgroundCallback: (tick) {},
          callback: (completer) {
            Future.delayed(const Duration(milliseconds: 10), () {
              completer.complete(
                BackgroundPollResult(
                  status: BackgroundPollResultStatus.ok,
                  result: 'Success',
                ),
              );
            });
          },
          onError: (error) {},
        ),
      );

      expect(actual, 'Success');
    });

    test('calls completes ok without result', () async {
      final actual = await backgroundPoll<String>(
        BackgroundPollRule(
          interval: const Duration(milliseconds: 100),
          backgroundCallback: (tick) {},
          callback: (completer) {
            Future.delayed(const Duration(milliseconds: 10), () {
              completer.complete(
                BackgroundPollResult(status: BackgroundPollResultStatus.ok),
              );
            });
          },
          onError: (error) {},
        ),
      );

      expect(actual, isNull);
    });

    test('calls completes with error status with exception', () async {
      dynamic errorReturned;

      final actual = await backgroundPoll<String>(
        BackgroundPollRule(
          interval: const Duration(milliseconds: 100),
          backgroundCallback: (tick) {},
          callback: (completer) {
            Future.delayed(const Duration(milliseconds: 10), () {
              completer.complete(
                BackgroundPollResult(
                  status: BackgroundPollResultStatus.error,
                  error: 'Error',
                ),
              );
            });
          },
          onError: (error) {
            errorReturned = error;
          },
        ),
      );

      expect(actual, isNull);
      expect(errorReturned, 'Error');
    });

    test('calls completes with error status without exception', () async {
      dynamic errorReturned;

      final actual = await backgroundPoll<String>(
        BackgroundPollRule(
          interval: const Duration(milliseconds: 100),
          backgroundCallback: (tick) {},
          callback: (completer) {
            Future.delayed(const Duration(milliseconds: 10), () {
              completer.complete(
                BackgroundPollResult(
                  status: BackgroundPollResultStatus.error,
                ),
              );
            });
          },
          onError: (error) {
            errorReturned = error;
          },
        ),
      );

      expect(actual, isNull);
      expect(errorReturned, isNull);
    });

    test(
        'calls backgroundCallback correct number of times '
        'and completes with result', () async {
      var lastTick = 0;
      var backgroundCallBackCount = 0;

      final actual = await backgroundPoll<String>(
        BackgroundPollRule(
          interval: const Duration(milliseconds: 100),
          backgroundCallback: (tick) {
            backgroundCallBackCount++;
            lastTick = tick;
          },
          callback: (completer) {
            Future.delayed(const Duration(milliseconds: 250), () {
              completer.complete(
                BackgroundPollResult(
                  status: BackgroundPollResultStatus.ok,
                  result: 'Success',
                ),
              );
            });
          },
          onError: (error) {},
        ),
      );

      expect(lastTick, 2, reason: 'lastTick did not match');
      expect(
        backgroundCallBackCount,
        2,
        reason: 'backgroundCallBackCount did not match',
      );
      expect(actual, 'Success', reason: 'actual result did not match');
    });

    test(
        'calls backgroundCallback 0 number of times because callback '
        'completes before interval', () async {
      var backgroundCallBackCount = 0;

      await backgroundPoll<String>(
        BackgroundPollRule(
          interval: const Duration(milliseconds: 15),
          backgroundCallback: (tick) {
            backgroundCallBackCount++;
          },
          callback: (completer) {
            Future.delayed(const Duration(milliseconds: 10), () {
              completer.complete(
                BackgroundPollResult(status: BackgroundPollResultStatus.ok),
              );
            });
          },
          onError: (error) {},
        ),
      );

      expect(backgroundCallBackCount, isZero);
    });

    test('completes with error if backgroundCallback throws exception',
        () async {
      dynamic errorReturned;

      final actual = await backgroundPoll<String>(
        BackgroundPollRule(
          interval: const Duration(milliseconds: 10),
          backgroundCallback: (tick) {
            throw Exception('big-bada-boom');
          },
          callback: (completer) {
            Future.delayed(const Duration(milliseconds: 15), () {
              if (!completer.isCompleted) {
                completer.complete(
                  BackgroundPollResult(
                    status: BackgroundPollResultStatus.ok,
                  ),
                );
              }
            });
          },
          onError: (error) {
            errorReturned = error;
          },
        ),
      );

      expect(actual, isNull);
      expect(
        errorReturned,
        isA<Exception>().having(
          (ex) => ex.toString(),
          'toString',
          'Exception: big-bada-boom',
        ),
      );
    });

    test('completes with error if callback throws exception', () async {
      dynamic errorReturned;

      final actual = await backgroundPoll<String>(
        BackgroundPollRule(
          interval: const Duration(milliseconds: 10),
          backgroundCallback: (tick) {},
          callback: (completer) {
            throw Exception('multi-pass');
          },
          onError: (error) {
            errorReturned = error;
          },
        ),
      );

      expect(actual, isNull);
      expect(
        errorReturned,
        isA<Exception>().having(
          (ex) => ex.toString(),
          'toString',
          'Exception: multi-pass',
        ),
      );
    });

    test(
        'completes ok even though callback calls completer.complete and '
        'throws exception', () async {
      dynamic errorReturned;

      final actual = await backgroundPoll<String>(
        BackgroundPollRule(
          interval: const Duration(milliseconds: 10),
          backgroundCallback: (tick) {},
          callback: (completer) {
            completer.complete(
              BackgroundPollResult(
                status: BackgroundPollResultStatus.ok,
                result: 'Actually ok!',
              ),
            );
            throw Exception('multi-pass');
          },
          onError: (error) {
            errorReturned = error;
          },
        ),
      );

      expect(actual, 'Actually ok!');
      expect(errorReturned, isNull);
    });
  });
}
