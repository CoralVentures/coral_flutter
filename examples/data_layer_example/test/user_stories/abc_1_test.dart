import 'package:coral_tester/coral_tester.dart';
import 'package:data_layer_example/blocs/analytic_listeners.dart';
import 'package:data_layer_example/blocs/quote/bloc.dart';
import 'package:data_layer_example/data_providers/quotable/models.dart';
import 'package:data_layer_example/pages/home/page.dart';
import 'package:data_layer_example/pages/home/widgets/connector/quote_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocked_app.dart';

void main() {
  coralTestGroup(
    'ABC-1',
    (userStoryId) {
      coralTestMockedApp<MockedApp>(
        '''As a user, I want to be able to see a random quote, so that I can get amusement.''',
        userStoryId: userStoryId,
        screenshotDir: 'random_quote',
        mockedApp: MockedApp(MocksContainer()),
        analyticListeners: analyticListeners,
        test: (screenshot) async {
          await screenshot(
            description:
                '''When I first open the app, I want to be on the home page and see a button to get a random quote.''',
            expectations: (expect) {
              expect(
                find.byType(Home_Page),
                findsOneWidget,
                reason: 'Should be on the home page',
              );
              expect(
                find.byType(HomeC_QuoteButton),
                findsOneWidget,
                reason: 'Should see button that will generate a random quote',
              );
            },
            expectedEvents: [],
            expectedAnalytics: ['Screen: Home'],
          );

          await screenshot(
            description:
                '''When I tap on the random quote button, I should see a quote displayed on the screen.''',
            mocks: (mockedApp) {
              when(
                () => mockedApp.mocks.quoteRepository.getRandomQuote(),
              ).thenAnswer(
                (_) async => const QuotableQuote(
                  id: '1',
                  content: 'I know that I know nothing',
                ),
              );
            },
            actions: (userAction, testerAction) async {
              await userAction.tap(
                find.byType(HomeC_QuoteButton),
              );
              await testerAction.pumpAndSettle();
            },
            expectations: (expect) {
              expect(
                find.text('I know that I know nothing'),
                findsOneWidget,
                reason: 'Should see a random quote displayed',
              );
            },
            expectedEvents: [QuoteEvent_RandomQuote],
            expectedAnalytics: ['Track: Quote: Get Random Quote'],
          );

          await screenshot(
            description:
                '''If I tap on the random quote button, and there is an error, I should see a snack bar.''',
            mocks: (mockedApp) {
              when(
                mockedApp.mocks.quoteRepository.getRandomQuote,
              ).thenThrow(Exception('BOOM'));
            },
            actions: (userAction, testerAction) async {
              await userAction.tap(
                find.byType(HomeC_QuoteButton),
              );
              await testerAction.pumpAndSettle();
            },
            expectations: (expect) {
              expect(
                find.text('I know that I know nothing'),
                findsNothing,
                reason: 'Should not see the random quote anymore',
              );
              expect(
                find.byType(SnackBar),
                findsOneWidget,
                reason: 'Should see an error snack bar',
              );
              expect(
                find.text('Uh oh, something went wrong'),
                findsOneWidget,
                reason: 'Should see error text that something went wrong',
              );
            },
            expectedEvents: [QuoteEvent_RandomQuote],
            expectedAnalytics: ['Track: Quote: Get Random Quote'],
          );
        },
      );
    },
  );
}
