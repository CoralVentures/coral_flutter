import 'dart:io';

import 'package:coral_bootstrap/coral_bootstrap.dart';

import '../app/builder.dart';
import '../blocs/analytic_listeners.dart';
import '../blocs/redux_remote_devtools.dart';
import 'configuration.dart';

void main() async {
  shouldConnectReduxRemoteDevtools = true;

  /// if [shouldConnectRemoteReduxDevtools] is true, then a remote devtools
  /// store will be created
  remoteReduxDevtoolsStore = await createReduxRemoteDevtoolsStore();

  final configuration = MainConfiguration.development(isIOS: Platform.isIOS);

  await coralBootstrap(
    builder: appBuilder,
    analyticListeners: analyticListeners,
    configuration: configuration,
  );
}
