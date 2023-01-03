import 'dart:io';
import 'package:coral_bootstrap/coral_bootstrap.dart';
import '../app/builder.dart';
import '../blocs/analytic_listeners.dart';
import 'configuration.dart';

void main() async {
  final configuration = MainConfiguration.development(isIOS: Platform.isIOS);

  await coralBootstrap(
    builder: appBuilder,
    analyticListeners: analyticListeners,
    configuration: configuration,
  );
}
