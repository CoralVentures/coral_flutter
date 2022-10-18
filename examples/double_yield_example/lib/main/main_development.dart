import 'dart:io';
import 'package:coral_bootstrap/coral_bootstrap.dart';
import 'package:double_yield_example/app/app_builder.dart';
import 'package:double_yield_example/blocs/analytic_listeners.dart';
import 'package:double_yield_example/main/main_configuration.dart';

void main() async {
  final configuration = MainConfiguration.development(isIOS: Platform.isIOS);

  await coralBootstrap(
    builder: appBuilder,
    analyticListeners: analyticListeners,
    configuration: configuration,
  );
}
