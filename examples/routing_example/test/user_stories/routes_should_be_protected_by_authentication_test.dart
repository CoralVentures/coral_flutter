import 'package:coral_tester/coral_tester.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routing_example/blocs/analytic_listeners.dart';
import 'package:routing_example/blocs/authentication/authentication_bloc.dart';
import 'package:routing_example/pages/home/home_page.dart';
import 'package:routing_example/pages/home/widget_connectors/logout_button.dart';
import 'package:routing_example/pages/login/login_page.dart';
import 'package:routing_example/pages/login/widget_connectors/login_fail_button.dart';
import 'package:routing_example/pages/login/widget_connectors/login_success_button.dart';

import '../mocked_app.dart';

void main() {
  group(
    'routes should be protected by authentication:',
    () {
      const groupPath = 'routes_should_be_protected_by_authentication';
      coralTestMockedApp<MockedApp>(
        '''As a user, if I am not logged in, I would like to be able to login''',
        mockedApp: MockedApp(MocksContainer()),
        analyticListeners: analyticListeners,
        basePath: '${groupPath}__logged_out',
        test: (tester) async {
          when(
            () => tester.mockedApp.mocks.authenticationRepository.authenticate(
              isAuthenticated: any(named: 'isAuthenticated'),
            ),
          ).thenReturn(false);

          await tester.pumpApp();

          await tester.screenshot(
            comment:
                '''If this is my first time opening the app, I should start on the login page''',
            takeActions: () async {},
            runExpectations: () {
              tester
                ..expectWithReason(
                  find.byType(Login_Page),
                  findsOneWidget,
                  reason: 'I should be on the login page',
                )
                ..expectWithReason(
                  find.byType(Home_Page),
                  findsNothing,
                  reason: 'I should not be on the home page.',
                );
            },
            expectedEvents: [AuthenticationEvent_Initialize],
            expectedAnalytics: ['Screen: login'],
          );

          await tester.screenshot(
            comment:
                '''If I attempt to log in, and I am authenticated, I should go to the home page''',
            takeActions: () async {
              when(
                () => tester.mockedApp.mocks.authenticationRepository
                    .authenticate(
                  isAuthenticated: any(named: 'isAuthenticated'),
                ),
              ).thenReturn(true);

              await tester.tap(
                find.byType(LoginC_LoginSuccessButton),
                pumpAndSettle: true,
              );
            },
            runExpectations: () {
              tester
                ..expectWithReason(
                  find.byType(Home_Page),
                  findsOneWidget,
                  reason: 'I should now be on the home page.',
                )
                ..expectWithReason(
                  find.byType(Login_Page),
                  findsNothing,
                  reason: 'I should not be on the login page',
                );
            },
            expectedEvents: [
              AuthenticationEvent_Login,
              AuthenticationEvent_LoginSucceeded,
            ],
            expectedAnalytics: [
              'Track: Login Attempted',
              'Track: Login Succeeded',
              'Screen: home'
            ],
          );
        },
      );

      coralTestMockedApp<MockedApp>(
        '''As a user, if I am already logged in, I would like to be able to log out''',
        mockedApp: MockedApp(MocksContainer()),
        analyticListeners: analyticListeners,
        basePath: '${groupPath}__logged_in',
        test: (tester) async {
          when(
            () => tester.mockedApp.mocks.authenticationRepository.authenticate(
              isAuthenticated: any(named: 'isAuthenticated'),
            ),
          ).thenReturn(true);

          await tester.pumpApp();

          await tester.screenshot(
            comment:
                '''If this is my first time opening the app, and I am still authenticated, I should start on the home page''',
            takeActions: () async {},
            runExpectations: () {
              tester
                ..expectWithReason(
                  find.byType(Home_Page),
                  findsOneWidget,
                  reason: 'I should be on the home page',
                )
                ..expectWithReason(
                  find.byType(Login_Page),
                  findsNothing,
                  reason: 'I should not be on the login page.',
                );
            },
            expectedEvents: [AuthenticationEvent_Initialize],
            expectedAnalytics: ['Screen: home'],
          );

          await tester.screenshot(
            comment:
                '''If I attempt to log out, I should go to the login page''',
            takeActions: () async {
              await tester.tap(
                find.byType(HomeC_LogoutButton),
                pumpAndSettle: true,
              );
            },
            runExpectations: () {
              tester
                ..expectWithReason(
                  find.byType(Login_Page),
                  findsOneWidget,
                  reason: 'I should now be on the login page.',
                )
                ..expectWithReason(
                  find.byType(Home_Page),
                  findsNothing,
                  reason: 'I should not be on the home page',
                );
            },
            expectedEvents: [
              AuthenticationEvent_Logout,
            ],
            expectedAnalytics: [
              'Track: Logout',
              'Screen: login',
            ],
          );
        },
      );

      coralTestMockedApp<MockedApp>(
        '''As a user, if I attempt to login and I cannot authenticate, I would like to be made aware''',
        mockedApp: MockedApp(MocksContainer()),
        analyticListeners: analyticListeners,
        basePath: '${groupPath}__login_failed',
        test: (tester) async {
          when(
            () => tester.mockedApp.mocks.authenticationRepository.authenticate(
              isAuthenticated: any(named: 'isAuthenticated'),
            ),
          ).thenReturn(false);

          await tester.pumpApp();

          await tester.screenshot(
            comment:
                '''If this is my first time opening the app, and I am not authenticated, I should be on the login page''',
            takeActions: () async {},
            runExpectations: () {
              tester
                ..expectWithReason(
                  find.byType(Login_Page),
                  findsOneWidget,
                  reason: 'I should be on the login page',
                )
                ..expectWithReason(
                  find.byType(Home_Page),
                  findsNothing,
                  reason: 'I should not be on the home page.',
                );
            },
            expectedEvents: [AuthenticationEvent_Initialize],
            expectedAnalytics: ['Screen: login'],
          );

          await tester.screenshot(
            comment:
                '''If I attempt to log in, and I cannot authenticate, I should see a snackbar''',
            takeActions: () async {
              await tester.tap(
                find.byType(LoginC_LoginFailButton),
                pumpAndSettle: true,
              );
              await tester.tester.pump();
            },
            runExpectations: () {
              tester
                ..expectWithReason(
                  find.byType(Login_Page),
                  findsOneWidget,
                  reason: 'I should still be on the login page',
                )
                ..expectWithReason(
                  find.byType(SnackBar),
                  findsOneWidget,
                  reason: 'I should see a snackbar',
                );
            },
            expectedEvents: [
              AuthenticationEvent_Login,
              AuthenticationEvent_LoginFailed,
            ],
            expectedAnalytics: [
              'Track: Login Attempted',
              'Track: Login Failed',
              'Screen: login',
            ],
          );
        },
      );

      coralTestMockedApp<MockedApp>(
        '''As a user, if I attempt to login and authentication throws an error, I would like to be made aware''',
        mockedApp: MockedApp(MocksContainer()),
        analyticListeners: analyticListeners,
        basePath: '${groupPath}__login_error',
        test: (tester) async {
          when(
            () => tester.mockedApp.mocks.authenticationRepository.authenticate(
              isAuthenticated: any(named: 'isAuthenticated'),
            ),
          ).thenReturn(false);

          await tester.pumpApp();

          await tester.screenshot(
            comment:
                '''If this is my first time opening the app, and I am not authenticated, I should be on the login page''',
            takeActions: () async {},
            runExpectations: () {
              tester
                ..expectWithReason(
                  find.byType(Login_Page),
                  findsOneWidget,
                  reason: 'I should be on the login page',
                )
                ..expectWithReason(
                  find.byType(Home_Page),
                  findsNothing,
                  reason: 'I should not be on the home page.',
                );
            },
            expectedEvents: [AuthenticationEvent_Initialize],
            expectedAnalytics: ['Screen: login'],
          );

          await tester.screenshot(
            comment:
                '''If I attempt to log in, and the authentication throws an error, I should see a snackbar''',
            takeActions: () async {
              when(
                () => tester.mockedApp.mocks.authenticationRepository
                    .authenticate(
                  isAuthenticated: any(named: 'isAuthenticated'),
                ),
              ).thenThrow(Exception('BOOM'));

              await tester.tap(
                find.byType(LoginC_LoginSuccessButton),
                pumpAndSettle: true,
              );
              await tester.tester.pump();
            },
            runExpectations: () {
              tester
                ..expectWithReason(
                  find.byType(Login_Page),
                  findsOneWidget,
                  reason: 'I should still be on the login page',
                )
                ..expectWithReason(
                  find.byType(SnackBar),
                  findsOneWidget,
                  reason: 'I should see a snackbar',
                );
            },
            expectedEvents: [
              AuthenticationEvent_Login,
              AuthenticationEvent_LoginFailed,
            ],
            expectedAnalytics: [
              'Track: Login Attempted',
              'Track: Login Failed',
              'Screen: login'
            ],
          );
        },
      );
    },
  );
}
