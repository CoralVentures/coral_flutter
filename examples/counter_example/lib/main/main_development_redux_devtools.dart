import 'package:coral_bootstrap/coral_bootstrap.dart';
import 'package:counter_example/app/app_builder.dart';
import 'package:counter_example/blocs/redux_remote_devtools.dart';
import 'package:counter_example/main/main_configuration.dart';

void main() async {
  shouldConnectReduxRemoteDevtools = true;

  /// if [shouldConnectRemoteReduxDevtools] is true, then a remote devtools
  /// store will be created
  remoteReduxDevtoolsStore = await createReduxRemoteDevtoolsStore();

  final configuration = MainConfiguration.development();

  await coralBootstrap(
    builder: appBuilder,
    segmentWriteApiKey: configuration.segmentConfiguration.apiWriteKey,
    sentryDSN: configuration.sentryConfiguration.dsn,
  );
}
