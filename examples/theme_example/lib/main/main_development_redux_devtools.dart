import 'dart:io';
import 'package:coral_bootstrap/coral_bootstrap.dart';
import 'package:theme_example/app/app_builder.dart';
import 'package:theme_example/app/app_theme.dart';
import 'package:theme_example/blocs/analytic_listeners.dart';
import 'package:theme_example/blocs/redux_remote_devtools.dart';
import 'package:theme_example/main/main_configuration.dart';

void main() async {
  shouldConnectReduxRemoteDevtools = true;

  /// if [shouldConnectRemoteReduxDevtools] is true, then a remote devtools
  /// store will be created
  remoteReduxDevtoolsStore = await createReduxRemoteDevtoolsStore();

  final configuration = MainConfiguration.development(isIOS: Platform.isIOS);

  await coralBootstrap(
    builder: ({analyticsRepository}) => appBuilder(
      analyticsRepository: analyticsRepository,
      coralThemeDataLight: appThemeDataLight,
      coralThemeDataDark: appThemeDataDark,
    ),
    analyticListeners: analyticListeners,
    configuration: configuration,
  );
}
