import 'dart:async';
import 'package:local_auth/local_auth.dart';

enum CoralBiometricsStatus {
  unknown,

  /// device can't use biometrics
  unsupported,

  /// device can use biometrics, but the user has not set it up
  supportedButNotSetUp,

  /// device can use biometrics, the user has set it up, but the user did not
  /// pass biometric authentication
  authenticationFailed,

  /// the user passed biometric authentication
  authenticationPassed,
}

class CoralBiometricsRepository {
  CoralBiometricsRepository({
    required this.localAuthentication,
  });

  final LocalAuthentication localAuthentication;

  Future<CoralBiometricsStatus> authenticateWithBiometrics({
    required String authDescription,
  }) async {
    // ignore: unused_local_variable
    var biometricsStatus = CoralBiometricsStatus.unknown;

    final canUseBiometircs = await localAuthentication.canCheckBiometrics ||
        await localAuthentication.isDeviceSupported();

    if (!canUseBiometircs) {
      return biometricsStatus = CoralBiometricsStatus.unsupported;
    }

    List<BiometricType>? availableBiometrics;

    try {
      availableBiometrics = await localAuthentication.getAvailableBiometrics();
    } catch (_) {
      return biometricsStatus = CoralBiometricsStatus.supportedButNotSetUp;
    }

    /// Note: we are simply checking if the available biometrics array is not
    /// empty. We have made a design choice to not worry about the specific type
    /// of biometric option because it is too brittle, we only care that there
    /// are biometrics available.
    if (availableBiometrics.isEmpty) {
      return biometricsStatus = CoralBiometricsStatus.supportedButNotSetUp;
    }

    var isAuthenticated = false;

    try {
      isAuthenticated = await localAuthentication.authenticate(
        localizedReason: authDescription,
      );
    } catch (_) {
      await localAuthentication.stopAuthentication();
      return biometricsStatus = CoralBiometricsStatus.authenticationFailed;
    }

    if (!isAuthenticated) {
      return biometricsStatus = CoralBiometricsStatus.authenticationFailed;
    }

    return biometricsStatus = CoralBiometricsStatus.authenticationPassed;
  }
}
