import 'package:coral_tester/coral_tester.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routing_example/app/app_builder.dart';
import 'package:routing_example/repositories/authentication/authentication_repository.dart';

class MockedApp extends CoralMockedApp {
  MockedApp(this.mocks)
      : super(
          appBuilder: ({analyticsRepository}) => appBuilder(
            analyticsRepository: analyticsRepository,
            authenticationRepository: mocks.authenticationRepository,
          ),
        );

  final MocksContainer mocks;
}

class MocksContainer {
  MockAuthenticationRepository authenticationRepository =
      MockAuthenticationRepository();
}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}
