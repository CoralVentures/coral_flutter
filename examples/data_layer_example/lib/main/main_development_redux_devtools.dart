import 'dart:io';
import 'package:coral_bootstrap/coral_bootstrap.dart';
import 'package:data_layer_example/app/app_builder.dart';
import 'package:data_layer_example/blocs/redux_remote_devtools.dart';
import 'package:data_layer_example/data_providers/quotable/quotable_data_provider.dart';
import 'package:data_layer_example/main/main_configuration.dart';
import 'package:data_layer_example/repositories/quote/quote_repository.dart';

void main() async {
  shouldConnectReduxRemoteDevtools = true;

  /// if [shouldConnectRemoteReduxDevtools] is true, then a remote devtools
  /// store will be created
  remoteReduxDevtoolsStore = await createReduxRemoteDevtoolsStore();

  final configuration = MainConfiguration.development(isIOS: Platform.isIOS);

  final quotableDataProvider = QuotableDataProvider();
  final quoteRepository =
      QuoteRepository(quotableDataProvider: quotableDataProvider);

  await coralBootstrap(
    builder: ({analyticsRepository}) => appBuilder(
      analyticsRepository: analyticsRepository,
      quoteRepository: quoteRepository,
    ),
    configuration: configuration,
  );
}
