import 'package:coral_tester/coral_tester.dart';
import 'package:data_layer_example/app/builder.dart';
import 'package:data_layer_example/repositories/quote/repository.dart';
import 'package:mocktail/mocktail.dart';

class MockedApp extends CoralMockedApp {
  MockedApp(this.mocks)
      : super(
          appBuilder: ({analyticsRepository}) => appBuilder(
            analyticsRepository: analyticsRepository,
            quoteRepository: mocks.quoteRepository,
          ),
        );

  final MocksContainer mocks;
}

class MocksContainer {
  MockQuoteRepository quoteRepository = MockQuoteRepository();
}

class MockQuoteRepository extends Mock implements QuoteRepository {}
