import 'package:clock/clock.dart';
import 'package:coral_error_monitoring_repository/coral_error_monitoring_repository.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class CoralErrorMonitoringRepository {
  CoralErrorMonitoringRepository({
    required this.sentryConfiguration,
    required this.deviceInfoPlugin,
  });

  final CoralSentryConfiguration sentryConfiguration;
  final DeviceInfoPlugin deviceInfoPlugin;

  /// Initializes Sentry with device information.
  Future<void> init() async {
    SentryNavigatorObserver();
    await Sentry.init(
      (options) {
        options
          ..dsn = sentryConfiguration.dsn
          ..environment = sentryConfiguration.sentryEnvironment;
      },
    );

    late SentryDevice sentryDevice;
    late SentryOperatingSystem sentryOs;
    final sentryTags = <String, String?>{};

    if (sentryConfiguration.isIOS) {
      final iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      sentryDevice = SentryDevice(
        name: iosDeviceInfo.name,
        model: iosDeviceInfo.model,
        modelId: iosDeviceInfo.identifierForVendor,
        simulator: !iosDeviceInfo.isPhysicalDevice,
        timezone: clock.now().timeZoneName,
      );

      sentryOs = SentryOperatingSystem(
        name: iosDeviceInfo.systemName,
        version: iosDeviceInfo.systemVersion,
      );

      sentryTags.addAll({
        'name': iosDeviceInfo.name,
        'model': iosDeviceInfo.model,
        'systemName': iosDeviceInfo.systemName,
        'systemVersion': iosDeviceInfo.systemVersion,
        'localizedModel': iosDeviceInfo.localizedModel,
        'utsname': iosDeviceInfo.utsname.sysname,
        'identifierForVendor': iosDeviceInfo.identifierForVendor,
        'isPhysicalDevice': '${iosDeviceInfo.isPhysicalDevice}',
      });
    } else {
      final androidDeviceInfo = await deviceInfoPlugin.androidInfo;

      sentryDevice = SentryDevice(
        name: androidDeviceInfo.product,
        arch: androidDeviceInfo.hardware,
        brand: androidDeviceInfo.brand,
        manufacturer: androidDeviceInfo.manufacturer,
        model: androidDeviceInfo.model,
        modelId: androidDeviceInfo.id,
        simulator: !androidDeviceInfo.isPhysicalDevice,
        timezone: clock.now().timeZoneName,
      );
      sentryOs = SentryOperatingSystem(
        name: androidDeviceInfo.version.codename,
        build: androidDeviceInfo.version.baseOS,
        kernelVersion: '${androidDeviceInfo.version.sdkInt}',
        version: androidDeviceInfo.version.release,
      );
      sentryTags.addAll({
        'type': androidDeviceInfo.type,
        'model': androidDeviceInfo.model,
        'device': androidDeviceInfo.device,
        'id': androidDeviceInfo.id,
        'brand': androidDeviceInfo.brand,
        'display': androidDeviceInfo.display,
        'hardware': androidDeviceInfo.hardware,
        'manufacturer': androidDeviceInfo.manufacturer,
        'product': androidDeviceInfo.product,
        'version': androidDeviceInfo.version.release,
        'supported32BitAbis': androidDeviceInfo.supported32BitAbis.join(','),
        'supported64BitAbis': androidDeviceInfo.supported64BitAbis.join(','),
        'supportedAbis': androidDeviceInfo.supportedAbis.join(','),
        'isPhysicalDevice': '${androidDeviceInfo.isPhysicalDevice}',
      });
    }

    Sentry.configureScope((scope) {
      // Configure Sentry Context
      // https://docs.sentry.io/platforms/flutter/enriching-events/context/
      scope
        ..setContexts(SentryDevice.type, sentryDevice)
        ..setContexts(SentryOperatingSystem.type, sentryOs);

      // Configure Sentry Tags
      // https://docs.sentry.io/platforms/flutter/enriching-events/tags/
      sentryTags.forEach((key, value) {
        scope.setTag(key, value ?? '');
      });
    });
  }

  /// Sets the current Sentry user or un-sets the user if the [userId] is null.
  void setUserId(String? userId) {
    Sentry.configureScope((scope) {
      scope.setUser(
        userId?.isNotEmpty ?? false
            ? SentryUser(
                id: userId,
              )
            : null,
      );
    });
  }

  /// Sets the sessionId.
  void setSessionId(String sessionId) {
    Sentry.configureScope((scope) {
      scope.setTag('sessionId', sessionId);
    });
  }
}
