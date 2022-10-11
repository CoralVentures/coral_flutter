import 'package:coral_bootstrap/coral_bootstrap.dart';
import 'package:counter_example/app_builder.dart';
import 'package:counter_example/blocs/redux_remote_devtools.dart';

void main() async {
  shouldConnectReduxRemoteDevtools = true;

  /// if [shouldConnectRemoteReduxDevtools] is true, then a remote devtools
  /// store will be created
  remoteReduxDevtoolsStore = await createReduxRemoteDevtoolsStore();

  await coralBootstrap(
    builder: appBuilder,
  );
}
