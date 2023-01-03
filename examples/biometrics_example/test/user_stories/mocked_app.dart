import 'package:biometrics_example/app/builder.dart';
import 'package:coral_biometrics_repository/coral_biometrics_repository.dart';
import 'package:coral_tester/coral_tester.dart';
import 'package:mocktail/mocktail.dart';

class MockedApp extends CoralMockedApp {
  MockedApp(this.mocks)
      : super(
          appBuilder: ({analyticsRepository}) => appBuilder(
            analyticsRepository: analyticsRepository,
            biometricsRepository: mocks.biometricsRepository,
          ),
        );

  final MocksContainer mocks;
}

class MocksContainer {
  MockBiometricsRepository biometricsRepository = MockBiometricsRepository();
}

class MockBiometricsRepository extends Mock
    implements CoralBiometricsRepository {}
