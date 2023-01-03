import 'package:biometrics_example/blocs/analytic_listeners.dart';
import 'package:biometrics_example/blocs/authentication/bloc.dart';
import 'package:coral_biometrics_repository/coral_biometrics_repository.dart';
import 'package:coral_tester/coral_tester.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mocked_app.dart';

void main() {
  coralTestGroup('ABC-1', (userStoryId) {
    coralTestMockedApp(
      '''As a user, if checking biometrics passes, I want to be taken to the home page, so that I can skip the login page and get there faster.''',
      userStoryId: userStoryId,
      mockedApp: MockedApp(MocksContainer()),
      analyticListeners: analyticListeners,
      screenshotDir: 'biometrics_passes',
      printApplicationLogs: false,
      mocksBeforeTest: (mockedApp) {
        when(
          () => mockedApp.mocks.biometricsRepository.authenticateWithBiometrics(
            authDescription: any(named: 'authDescription'),
          ),
        ).thenAnswer(
          (invocation) async => CoralBiometricsStatus.authenticationPassed,
        );
      },
      test: (screenshot) async {
        await screenshot(
          expectations: (expect) {
            expect(
              find.text('Home Page'),
              findsOneWidget,
              reason: '''Should see the home page when biometrics pass''',
            );
          },
          expectedEvents: [
            AuthenticationEvent_BiometricAuthenticationStarted,
            AuthenticationEvent_BiometricAuthenticationSucceeded,
          ],
          expectedAnalytics: [
            'Screen: Loading',
            'Track: Biometrics Authentication: Started',
            'Track: Biometrics Authentication: Succeeded',
            'Screen: Home',
          ],
        );
      },
    );

    coralTestMockedApp(
      '''As a user, if checking biometrics breaks, I want to be taken to the login page so I can still get inside the application.''',
      userStoryId: userStoryId,
      mockedApp: MockedApp(MocksContainer()),
      analyticListeners: analyticListeners,
      screenshotDir: 'biometrics_error',
      printApplicationLogs: false,
      test: (screenshot) async {
        await screenshot(
          expectations: (expect) {
            expect(
              find.text('Login Page'),
              findsOneWidget,
              reason:
                  '''If the biometrics repository breaks, should go to the login page''',
            );
            expect(
              find.text('Biometrics status: authenticationFailed'),
              findsOneWidget,
              reason:
                  '''If biometrics breaks, the status should be authentication failed''',
            );
          },
          expectedEvents: [
            AuthenticationEvent_BiometricAuthenticationStarted,
            AuthenticationEvent_BiometricAuthenticationFailed,
          ],
          expectedAnalytics: [
            'Screen: Loading',
            'Track: Biometrics Authentication: Started',
            'Track: Biometrics Authentication: Failed',
            'Screen: Login',
          ],
        );
      },
    );

    coralTestMockedApp(
      '''As a user, if biometrics are not supported, I want to be taken to the login page, so that I can login.''',
      userStoryId: userStoryId,
      mockedApp: MockedApp(MocksContainer()),
      analyticListeners: analyticListeners,
      screenshotDir: 'biometrics_unsupported',
      printApplicationLogs: false,
      mocksBeforeTest: (mockedApp) {
        when(
          () => mockedApp.mocks.biometricsRepository.authenticateWithBiometrics(
            authDescription: any(named: 'authDescription'),
          ),
        ).thenAnswer(
          (invocation) async => CoralBiometricsStatus.unsupported,
        );
      },
      test: (screenshot) async {
        await screenshot(
          expectations: (expect) {
            expect(
              find.text('Login Page'),
              findsOneWidget,
              reason:
                  '''Should see the login page when biometrics are unsupported''',
            );
          },
          expectedEvents: [
            AuthenticationEvent_BiometricAuthenticationStarted,
            AuthenticationEvent_BiometricAuthenticationFailed,
          ],
          expectedAnalytics: [
            'Screen: Loading',
            'Track: Biometrics Authentication: Started',
            'Track: Biometrics Authentication: Failed',
            'Screen: Login',
          ],
        );
      },
    );

    coralTestMockedApp(
      '''As a user, if biometrics are supported but not set up, I want to be taken to the login page, so that I can login.''',
      userStoryId: userStoryId,
      mockedApp: MockedApp(MocksContainer()),
      analyticListeners: analyticListeners,
      screenshotDir: 'biometrics_notSetUp',
      printApplicationLogs: false,
      mocksBeforeTest: (mockedApp) {
        when(
          () => mockedApp.mocks.biometricsRepository.authenticateWithBiometrics(
            authDescription: any(named: 'authDescription'),
          ),
        ).thenAnswer(
          (invocation) async => CoralBiometricsStatus.supportedButNotSetUp,
        );
      },
      test: (screenshot) async {
        await screenshot(
          expectations: (expect) {
            expect(
              find.text('Login Page'),
              findsOneWidget,
              reason:
                  '''Should see the login page when biometrics are supported but not set up''',
            );
          },
          expectedEvents: [
            AuthenticationEvent_BiometricAuthenticationStarted,
            AuthenticationEvent_BiometricAuthenticationFailed,
          ],
          expectedAnalytics: [
            'Screen: Loading',
            'Track: Biometrics Authentication: Started',
            'Track: Biometrics Authentication: Failed',
            'Screen: Login',
          ],
        );
      },
    );

    coralTestMockedApp(
      '''As a user, if biometrics are supported, set up but auth fails, I want to be taken to the login page, so that I can login.''',
      userStoryId: userStoryId,
      mockedApp: MockedApp(MocksContainer()),
      analyticListeners: analyticListeners,
      screenshotDir: 'biometrics_authFailed',
      printApplicationLogs: false,
      mocksBeforeTest: (mockedApp) {
        when(
          () => mockedApp.mocks.biometricsRepository.authenticateWithBiometrics(
            authDescription: any(named: 'authDescription'),
          ),
        ).thenAnswer(
          (invocation) async => CoralBiometricsStatus.authenticationFailed,
        );
      },
      test: (screenshot) async {
        await screenshot(
          expectations: (expect) {
            expect(
              find.text('Login Page'),
              findsOneWidget,
              reason:
                  '''Should see the login page when biometric authentication fails''',
            );
          },
          expectedEvents: [
            AuthenticationEvent_BiometricAuthenticationStarted,
            AuthenticationEvent_BiometricAuthenticationFailed,
          ],
          expectedAnalytics: [
            'Screen: Loading',
            'Track: Biometrics Authentication: Started',
            'Track: Biometrics Authentication: Failed',
            'Screen: Login',
          ],
        );
      },
    );
  });
}
