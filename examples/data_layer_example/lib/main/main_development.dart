import 'package:coral_bootstrap/coral_bootstrap.dart';
import 'package:data_layer_example/app/app_builder.dart';
import 'package:data_layer_example/data_providers/quotable/quotable_data_provider.dart';
import 'package:data_layer_example/main/main_configuration.dart';
import 'package:data_layer_example/repositories/quote/quote_repository.dart';

void main() async {
  final configuration = MainConfiguration.development();

  final quotableDataProvider = QuotableDataProvider();
  final quoteRepository =
      QuoteRepository(quotableDataProvider: quotableDataProvider);

  await coralBootstrap(
    builder: ({analyticsRepository}) => appBuilder(
      analyticsRepository: analyticsRepository,
      quoteRepository: quoteRepository,
    ),
    segmentWriteApiKey: configuration.segmentConfiguration.apiWriteKey,
    sentryDSN: configuration.sentryConfiguration.dsn,
  );
}
