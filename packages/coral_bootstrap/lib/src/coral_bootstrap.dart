import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:coral_bootstrap/src/coral_bloc_observer.dart';
import 'package:coral_logger/coral_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_segment/flutter_segment.dart';

typedef CoralAppBuilder = FutureOr<Widget> Function({
  CoralAnalyticsRepository? analyticsRepository,
});

/// This function will setup:
///
/// [CoralLogger] to print to the console and optionally to Sentry. To use
/// Sentry:
/// - pass in the [sentryDSN]
///
/// [CoralAnalyticsRepository] which optionally uses Segment. To use:
/// - pass in the [analyticListeners] that are listening to your Blocs.
/// - pass in the [segmentWriteApiKey]
///
/// Default error handling (i.e. logging the error). To override:
/// - flutter errors, pass in [flutterOnError],
/// - application errors, pass in [appZoneOnError]
///
Future<void> coralBootstrap({
  required CoralAppBuilder builder,
  String? segmentWriteApiKey,
  String? sentryDSN,
  List<CoralBlocObserverAnalyticListener<dynamic>> analyticListeners = const [],
  FlutterExceptionHandler flutterOnError = _flutterOnError,
  void Function(Object error, StackTrace stack) appZoneOnError =
      _appZoneOnError,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initializeLogger(sentryDSN: sentryDSN);

  final analyticsRepository =
      _createAnalyticsRepository(segmentWriteApiKey: segmentWriteApiKey);

  FlutterError.onError = flutterOnError;

  Bloc.observer = CoralBlocObserver(
    onEventCallback: createAnalyticsOnEventCallback(
      analyticListeners: analyticListeners,
      analyticsRepository: analyticsRepository,
    ),
  );

  await runZonedGuarded(
    () async => runApp(
      await builder(
        analyticsRepository: analyticsRepository,
      ),
    ),
    appZoneOnError,
  );
}

void _flutterOnError(FlutterErrorDetails details) {
  CoralLogger()
      .logError(details.exceptionAsString(), stacktrace: details.stack);
}

void _appZoneOnError(Object error, StackTrace stackTrace) {
  CoralLogger().logError(error.toString(), stacktrace: stackTrace);
}

Future<void> _initializeLogger({
  required String? sentryDSN,
}) async {
  CoralLogger.addPrintClient();
  if (sentryDSN != null) {
    await CoralLogger.addSentryClient(sentryDSN);
  }
}

CoralAnalyticsRepository? _createAnalyticsRepository({
  String? segmentWriteApiKey,
}) {
  if (segmentWriteApiKey != null && segmentWriteApiKey.isNotEmpty) {
    return CoralAnalyticsRepository(
      onTrack: Segment.track,
      onIdentify: Segment.identify,
      onScreen: Segment.screen,
      onInit: () => Segment.config(
        options: SegmentConfig(
          writeKey: segmentWriteApiKey,
          trackApplicationLifecycleEvents: true,
        ),
      ),
    );
  }
  return null;
}
