import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:coral_error_monitoring_repository/coral_error_monitoring_repository.dart';

class CoralBootstrapConfiguration {
  CoralBootstrapConfiguration({
    this.segmentConfiguration,
    this.sentryConfiguration,
  });

  final CoralSegmentConfiguration? segmentConfiguration;
  final CoralSentryConfiguration? sentryConfiguration;
}
