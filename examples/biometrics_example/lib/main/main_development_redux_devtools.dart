import 'dart:io';

import 'package:biometrics_example/app/app_builder.dart';
import 'package:biometrics_example/blocs/analytic_listeners.dart';
import 'package:biometrics_example/blocs/redux_remote_devtools.dart';
import 'package:biometrics_example/main/main_configuration.dart';
import 'package:coral_biometrics_repository/coral_biometrics_repository.dart';
import 'package:coral_bootstrap/coral_bootstrap.dart';
import 'package:local_auth/local_auth.dart';

void main() async {
  shouldConnectReduxRemoteDevtools = true;

  /// if [shouldConnectRemoteReduxDevtools] is true, then a remote devtools
  /// store will be created
  remoteReduxDevtoolsStore = await createReduxRemoteDevtoolsStore();

  final configuration = MainConfiguration.development(isIOS: Platform.isIOS);

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
