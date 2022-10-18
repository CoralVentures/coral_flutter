import 'dart:convert';

import 'package:data_layer_example/data_providers/quotable/quotable_models.dart';
import 'package:http/http.dart' as http;

class QuotableDataProvider {
  QuotableDataProvider({
    http.Client? httpClient,
  }) : _httpClient = httpClient;
  final http.Client? _httpClient;

  final _randomQuoteUri = Uri.https('api.quotable.io', '/random');

  Future<QuotableQuote> getRandomQuote() async {
    final client = _httpClient ?? http.Client();

    final response = await client.get(_randomQuoteUri);

    if (response.statusCode != 200) throw Exception();

    final bodyMap = jsonDecode(response.body) as Map<String, dynamic>;

    final quote = QuotableQuote.fromJson(bodyMap);

    return quote;
  }
}
