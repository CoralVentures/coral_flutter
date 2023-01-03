import 'dart:convert';

import 'package:data_layer_example/data_providers/quotable/data_provider.dart';
import 'package:data_layer_example/data_providers/quotable/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

const mockQuoteAsString =
    '''{"_id":"some-id","content":"If you're trying to achieve, there will be roadblocks. I've had them; everybody has had them. But obstacles don't have to stop you. If you run into a wall, don't turn around and give up. Figure out how to climb it, go through it, or work around it.","author":"Michael Jordan","tags":["wisdom","inspirational"],"authorSlug":"michael-jordan","length":248,"dateAdded":"2021-03-28","dateModified":"2021-03-28"}''';

void main() {
  group(
    'QuoteableDataProvider',
    () {
      late MockHttpClient mockHttpClient;
      late QuotableDataProvider quotableDataProvider;

      setUp(() {
        mockHttpClient = MockHttpClient();
        quotableDataProvider = QuotableDataProvider(httpClient: mockHttpClient);
        registerFallbackValue(Uri.https('fallback.com'));
      });

      test(
        'getRandomQuote is successful',
        () async {
          when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
              .thenAnswer(
            (invocation) async => http.Response(
              mockQuoteAsString,
              200,
            ),
          );

          final quote = await quotableDataProvider.getRandomQuote();
          final mockQuoteJson =
              jsonDecode(mockQuoteAsString) as Map<String, dynamic>;

          expect(quote.id, 'some-id');
          expect(quote, QuotableQuote.fromJson(mockQuoteJson));
        },
      );

      test(
        'getRandomQuote returns a 404 and throws an exception',
        () async {
          when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
              .thenAnswer(
            (invocation) async => http.Response(
              'not found',
              404,
            ),
          );

          expect(() => quotableDataProvider.getRandomQuote(), throwsException);
        },
      );
    },
  );
}
