import 'package:data_layer_example/data_providers/quotable/quotable_data_provider.dart';
import 'package:data_layer_example/data_providers/quotable/quotable_models.dart';

/// Note: repositories in general can have 1 or more data providers, so the
/// purist recommendation is to have your data providers and repositories
/// separated. However, when repositories only have a single data provider, it
/// is ok to drop the data provider layer and do everything in the repository
/// for expediency.
///
/// This example has the data provider and repository separated.
///
class QuoteRepository {
  QuoteRepository({
    required QuotableDataProvider quotableDataProvider,
  }) : _quotableDataProvider = quotableDataProvider;

  final QuotableDataProvider _quotableDataProvider;

  Future<QuotableQuote> getRandomQuote() async {
    return _quotableDataProvider.getRandomQuote();
  }
}
