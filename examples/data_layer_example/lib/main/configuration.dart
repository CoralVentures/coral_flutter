// ignore_for_file: prefer_constructors_over_static_methods

import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:coral_bootstrap/coral_bootstrap.dart';
import 'package:coral_error_monitoring_repository/coral_error_monitoring_repository.dart';

class MainConfiguration {
  static CoralBootstrapConfiguration development({required bool isIOS}) =>
      CoralBootstrapConfiguration(
        segmentConfiguration: CoralSegmentConfiguration(
          apiWriteKey: 'change-me',
        ),
        sentryConfiguration: CoralSentryConfiguration(
          dsn: 'change-me',
          sentryEnvironment: 'development',
          isIOS: isIOS,
        ),
      );

  static CoralBootstrapConfiguration production({required bool isIOS}) =>
      CoralBootstrapConfiguration(
        segmentConfiguration: CoralSegmentConfiguration(
          apiWriteKey: 'change-me',
        ),
        sentryConfiguration: CoralSentryConfiguration(
          dsn: 'change-me',
          sentryEnvironment: 'production',
          isIOS: isIOS,
        ),
      );
}
