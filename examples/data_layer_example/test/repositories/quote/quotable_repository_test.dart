import 'package:data_layer_example/data_providers/quotable/quotable_data_provider.dart';
import 'package:data_layer_example/data_providers/quotable/quotable_models.dart';
import 'package:data_layer_example/repositories/quote/quote_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockQuotableDataProvider extends Mock implements QuotableDataProvider {}

void main() {
  group(
    'QuoteRepository',
    () {
      late MockQuotableDataProvider mockQuotableDataProvider;
      late QuoteRepository quoteRepository;

      setUp(() {
        mockQuotableDataProvider = MockQuotableDataProvider();
        quoteRepository =
            QuoteRepository(quotableDataProvider: mockQuotableDataProvider);
      });

      test(
        'getRandomQuote is successful',
        () async {
          when(() => mockQuotableDataProvider.getRandomQuote()).thenAnswer(
            (invocation) async =>
                const QuotableQuote(id: 'some-id', content: 'some-quote'),
          );

          final quote = await quoteRepository.getRandomQuote();

          expect(
            quote,
            const QuotableQuote(id: 'some-id', content: 'some-quote'),
          );
        },
      );
    },
  );
}
