import 'dart:io';
import 'package:coral_bootstrap/coral_bootstrap.dart';
import 'package:theme_example/app/app_builder.dart';
import 'package:theme_example/app/app_theme.dart';
import 'package:theme_example/blocs/analytic_listeners.dart';
import 'package:theme_example/main/main_configuration.dart';

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