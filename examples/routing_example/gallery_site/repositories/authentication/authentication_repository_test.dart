import 'package:flutter_test/flutter_test.dart';
import 'package:routing_example/repositories/authentication/authentication_repository.dart';

void main() {
  group('AuthenticationRepository', () {
    test('authenticate', () {
      final repository = AuthenticationRepository();

      expect(repository.authenticate(isAuthenticated: true), isTrue);
      expect(repository.authenticate(isAuthenticated: false), isFalse);
    });
  });
}
