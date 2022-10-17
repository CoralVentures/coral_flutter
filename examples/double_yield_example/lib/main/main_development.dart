import 'package:coral_bootstrap/coral_bootstrap.dart';
import 'package:double_yield_example/app/app_builder.dart';
import 'package:double_yield_example/main/main_configuration.dart';

void main() async {
  final configuration = MainConfiguration.development();

  await coralBootstrap(
    builder: appBuilder,
    segmentWriteApiKey: configuration.segmentConfiguration.apiWriteKey,
    sentryDSN: configuration.sentryConfiguration.dsn,
  );
}
