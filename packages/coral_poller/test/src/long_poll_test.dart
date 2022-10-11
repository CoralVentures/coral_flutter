import 'package:coral_poller/src/long_poll.dart';
import 'package:test/test.dart';

void main() {
  group('longPoll', () {
    test('completes ok with result immediately', () async {
      final actual = await longPoll<String>(
        LongPollRule(
          timeout: const Duration(milliseconds: 200),
          interval: const Duration(milliseconds: 100),
          onTimeout: () {},
          onError: (error) {},
          callback: (completer) async {
            completer.complete(
              LongPollResult(
                status: LongPollResultStatus.ok,
                result: 'Success',
              ),
            );
          },
        ),
      );

      expect(actual, 'Success');
    });

    test('completes ok with result after a few callbacks', () async {
      var count = 0;
      final actual = await longPoll<String>(
        LongPollRule(
          timeout: const Duration(milliseconds: 500),
          interval: const Duration(milliseconds: 100),
          onTimeout: () {},
          onError: (error) {},
          callback: (completer) async {
            if (count > 3) {
              completer.complete(
                LongPollResult(
                  status: LongPollResultStatus.ok,
                  result: 'Success',
                ),
              );
            }
            count++;
          },
        ),
      );

      expect(actual, 'Success');
    });

    test('times out', () async {
      var onTimeOutCalled = false;
      await longPoll<String>(
        LongPollRule(
          timeout: const Duration(milliseconds: 200),
          interval: const Duration(milliseconds: 100),
          onTimeout: () {
            onTimeOutCalled = true;
          },
          onError: (error) {},
          callback: (completer) async {
            /// Do nothing
          },
        ),
      );

      expect(onTimeOutCalled, isTrue);
    });

    test('errors', () async {
      Object? onErrorString;
      await longPoll<String>(
        LongPollRule(
          timeout: const Duration(milliseconds: 200),
          interval: const Duration(milliseconds: 100),
          onTimeout: () {},
          onError: (error) {
            onErrorString = error;
          },
          callback: (completer) async {
            throw Exception('err');
          },
        ),
      );

      expect(onErrorString.toString(), 'Exception: err');
    });
  });
}
