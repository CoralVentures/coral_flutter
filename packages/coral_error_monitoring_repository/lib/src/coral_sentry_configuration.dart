class CoralSentryConfiguration {
  CoralSentryConfiguration({
    required this.dsn,
    required this.sentryEnvironment,
    required this.isIOS,
  });

  final String dsn;
  final String sentryEnvironment;
  final bool isIOS;
}
