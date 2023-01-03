import 'dart:io';

import 'package:coral_bootstrap/coral_bootstrap.dart';

import '../app/builder.dart';
import '../app/theme.dart';
import '../blocs/analytic_listeners.dart';
import 'configuration.dart';

void main() async {
  final configuration = MainConfiguration.production(isIOS: Platform.isIOS);

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
