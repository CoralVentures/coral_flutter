import 'dart:io';

import 'package:coral_biometrics_repository/coral_biometrics_repository.dart';
import 'package:coral_bootstrap/coral_bootstrap.dart';
import 'package:local_auth/local_auth.dart';

import '../app/builder.dart';
import '../blocs/analytic_listeners.dart';
import 'configuration.dart';

void main() async {
  final configuration = MainConfiguration.production(isIOS: Platform.isIOS);

  final biometricsRepository = CoralBiometricsRepository(
    localAuthentication: LocalAuthentication(),
  );

  await coralBootstrap(
    builder: ({analyticsRepository}) => appBuilder(
      analyticsRepository: analyticsRepository,
      biometricsRepository: biometricsRepository,
    ),
    analyticListeners: analyticListeners,
    configuration: configuration,
  );
}
