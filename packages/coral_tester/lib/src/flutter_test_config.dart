import 'dart:async';
import 'dart:io';

import 'package:golden_toolkit/golden_toolkit.dart';

/// In your test directory, you will need to create a file called
/// `flutter_test_config.dart` and export this file:
///
/// ```
/// export 'package:coral_tester/src/flutter_test_config.dart';
/// ```

final List<Device> defaultGoldenDevices = [Device.iphone11, Device.phone];

/// See https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html.
/// Used to load fonts and configuration for golden tests.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return GoldenToolkit.runWithConfiguration(
    () async {
      await loadAppFonts();
      await testMain();
    },
    config: GoldenToolkitConfiguration(
      enableRealShadows: true,
      defaultDevices: defaultGoldenDevices,

      /// Skipping if not on MacOS because assuming CI/CD will not be on MacOS
      /// and local development will be.
      skipGoldenAssertion: () => !Platform.isMacOS,
    ),
  );
}
