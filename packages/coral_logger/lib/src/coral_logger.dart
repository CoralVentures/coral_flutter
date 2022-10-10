import 'package:lumberdash/lumberdash.dart' as l;
import 'package:print_lumberdash/print_lumberdash.dart';
import 'package:sentry/sentry.dart';
import 'package:sentry_lumberdash/sentry_lumberdash.dart';

/// {@template coral_logger}
/// [CoralLogger] should be used instead of other `print` options. Under the
/// hood, [CoralLogger] uses lumberdash which can control where it sends the
/// print statements. Currently it can:
/// - not send print statements anywhere (the default)
/// - send them do the console
/// - send them to Sentry
/// {@endtemplate}
class CoralLogger {
  /// {@macro coral_logger}
  CoralLogger() {
    l.putLumberdashToWork(withClients: _clients);
  }

  /// Note: this list is static and is attached to the class itself (not an
  /// instantiated object). So anytime you add a client, all instantiated
  /// objects will use that client.
  static final List<l.LumberdashClient> _clients = [];

  static void addPrintClient() {
    _clients.add(PrintLumberdash());
  }

  static Future<void> addSentryClient(String sentryDSN) async {
    await Sentry.init(
      (options) {
        options
          ..dsn = sentryDSN
          ..tracesSampleRate = 1.0;
      },
    );
    _clients.add(SentryLumberdash());
  }

  String logMessage(
    String message, {
    Map<String, String>? extras,
  }) {
    return l.logMessage(
      message,
      extras: extras,
    );
  }

  String logWarning(
    String message, {
    Map<String, String>? extras,
  }) {
    return l.logWarning(
      message,
      extras: extras,
    );
  }

  String logFatal(
    String message, {
    Map<String, String>? extras,
  }) {
    return l.logFatal(
      message,
      extras: extras,
    );
  }

  dynamic logError(
    dynamic exception, {
    dynamic stacktrace,
  }) {
    return l.logError(
      exception,
      stacktrace: stacktrace,
    );
  }
}
