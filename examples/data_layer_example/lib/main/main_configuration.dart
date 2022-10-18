// ignore_for_file: prefer_constructors_over_static_methods

class MainConfiguration {
  MainConfiguration({
    required this.segmentConfiguration,
    required this.sentryConfiguration,
  });

  final SegmentConfiguration segmentConfiguration;
  final SentryConfiguration sentryConfiguration;

  static MainConfiguration development() => MainConfiguration(
        segmentConfiguration: SegmentConfiguration(apiWriteKey: 'change-me'),
        sentryConfiguration: SentryConfiguration(dsn: 'change-me'),
      );

  static MainConfiguration production() => MainConfiguration(
        segmentConfiguration: SegmentConfiguration(apiWriteKey: 'change-me'),
        sentryConfiguration: SentryConfiguration(dsn: 'change-me'),
      );
}

class SegmentConfiguration {
  SegmentConfiguration({
    required this.apiWriteKey,
  });

  final String apiWriteKey;
}

class SentryConfiguration {
  SentryConfiguration({
    required this.dsn,
  });

  final String dsn;
}
