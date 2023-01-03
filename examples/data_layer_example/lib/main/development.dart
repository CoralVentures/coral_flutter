import 'dart:io';

import 'package:coral_bootstrap/coral_bootstrap.dart';

import '../app/builder.dart';
import '../data_providers/quotable/data_provider.dart';
import '../repositories/quote/repository.dart';
import 'configuration.dart';

void main() async {
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
