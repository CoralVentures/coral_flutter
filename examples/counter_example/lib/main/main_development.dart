import 'package:coral_bootstrap/coral_bootstrap.dart';
import 'package:counter_example/app/app_builder.dart';

void main() async {
  await coralBootstrap(
    builder: appBuilder,
  );
}
