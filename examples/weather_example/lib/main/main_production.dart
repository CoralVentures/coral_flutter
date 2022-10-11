import 'package:coral_bootstrap/coral_bootstrap.dart';
import 'package:weather_example/app_builder.dart';

void main() async {
  await coralBootstrap(
    builder: appBuilder,
  );
}
