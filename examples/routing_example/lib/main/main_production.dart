import 'package:coral_bootstrap/coral_bootstrap.dart';
import 'package:routing_example/app/app_builder.dart';
import 'package:routing_example/main/main_configuration.dart';
import 'package:routing_example/repositories/authentication/authentication_repository.dart';

void main() async {
  final configuration = MainConfiguration.development();

  final authenticationRepository = AuthenticationRepository();

  await coralBootstrap(
    builder: ({analyticsRepository}) {
      return appBuilder(
        analyticsRepository: analyticsRepository,
        authenticationRepository: authenticationRepository,
      );
    },
    segmentWriteApiKey: configuration.segmentConfiguration.apiWriteKey,
    sentryDSN: configuration.sentryConfiguration.dsn,
  );
}
