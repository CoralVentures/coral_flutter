import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:coral_bootstrap/coral_bootstrap.dart';
import 'package:coral_error_monitoring_repository/coral_error_monitoring_repository.dart';
import 'package:coral_logger/coral_logger.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:uuid/uuid.dart';

typedef CoralAppBuilder = FutureOr<Widget> Function({
  CoralAnalyticsRepository? analyticsRepository,
});

/// This function will setup:
///
/// [CoralLogger] to print to the console and optionally to Sentry. To use
/// Sentry:
/// - pass in the [CoralSentryConfiguration] to the
///   [CoralBootstrapConfiguration]
///
/// [CoralAnalyticsRepository] which optionally uses Segment. To use:
/// - pass in the [analyticListeners] that are listening to your Blocs.
/// - pass in the [CoralSegmentConfiguration] to the
///   [CoralBootstrapConfiguration]
///
/// Default error handling (i.e. logging the error). To override:
/// - flutter errors, pass in [flutterOnError],
/// - application errors, pass in [appZoneOnError]
///
Future<void> coralBootstrap({
  required CoralAppBuilder builder,
  required CoralBootstrapConfiguration configuration,
  List<CoralBlocObserverAnalyticListener<dynamic>> analyticListeners = const [],
  FlutterExceptionHandler flutterOnError = _flutterOnError,
  void Function(Object error, StackTrace stack) appZoneOnError =
      _appZoneOnError,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initializeLogger(sentryDSN: configuration.sentryConfiguration?.dsn);

  final analyticsRepository = _createAnalyticsRepository(
    segmentConfiguration: configuration.segmentConfiguration,
  );

  final errorMonitoringRepository = _createErrorMonitoringRepository(
    sentryConfiguration: configuration.sentryConfiguration,
  );

  await errorMonitoringRepository?.init();

  const uuid = Uuid();
  final sessionId = uuid.v4();
  analyticsRepository?.setCoralSessionId(sessionId);
  errorMonitoringRepository?.setSessionId(sessionId);

  FlutterError.onError = flutterOnError;

  Bloc.observer = CoralBlocObserver(
    onEventCallback: createAnalyticsOnEventCallback(
      analyticListeners: analyticListeners,
      analyticsRepository: analyticsRepository,
    ),
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

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
  CoralSegmentConfiguration? segmentConfiguration,
}) {
  if (segmentConfiguration != null) {
    return CoralAnalyticsRepository(
      onTrack: Segment.track,
      onIdentify: Segment.identify,
      onScreen: Segment.screen,
      onInit: () => Segment.config(
        options: SegmentConfig(
          writeKey: segmentConfiguration.apiWriteKey,
          trackApplicationLifecycleEvents: true,
        ),
      ),
    );
  }
  return null;
}

CoralErrorMonitoringRepository? _createErrorMonitoringRepository({
  CoralSentryConfiguration? sentryConfiguration,
}) {
  final deviceInfoPlugin = DeviceInfoPlugin();

  if (sentryConfiguration != null) {
    return CoralErrorMonitoringRepository(
      sentryConfiguration: sentryConfiguration,
      deviceInfoPlugin: deviceInfoPlugin,
    );
  }
  return null;
}
