import 'dart:io';

import 'package:bottom_nav_example/app/app_builder.dart';
import 'package:bottom_nav_example/blocs/analytic_listeners.dart';
import 'package:bottom_nav_example/main/main_configuration.dart';
import 'package:coral_bootstrap/coral_bootstrap.dart';

void main() async {
  final configuration = MainConfiguration.development(isIOS: Platform.isIOS);

  await coralBootstrap(
    builder: appBuilder,
    analyticListeners: analyticListeners,
    configuration: configuration,
  );
}
