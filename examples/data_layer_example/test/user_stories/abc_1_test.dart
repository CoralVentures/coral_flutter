import 'package:coral_tester/coral_tester.dart';
import 'package:data_layer_example/blocs/analytic_listeners.dart';
import 'package:data_layer_example/blocs/quote/quote_bloc.dart';
import 'package:data_layer_example/data_providers/quotable/quotable_models.dart';
import 'package:data_layer_example/pages/home/home_page.dart';
import 'package:data_layer_example/pages/home/widgets_connector/quote_button.dart';
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
        test: (tester) async {
          await tester.pumpApp();

          await tester.screenshot(
            comment:
                '''When I first open the app, I want to be on the home page and see a button to get a random quote.''',
            takeActions: () async {},
            runExpectations: () {
              tester
                ..expect(
                  find.byType(Home_Page),
                  findsOneWidget,
                  reason: 'Should be on the home page',
                )
                ..expect(
                  find.byType(HomeC_QuoteButton),
                  findsOneWidget,
                  reason: 'Should see button that will generate a random quote',
                );
            },
            expectedEvents: [],
            expectedAnalytics: ['Screen: home'],
          );

          await tester.screenshot(
            comment:
                '''When I tap on the random quote button, I should see a quote displayed on the screen.''',
            takeActions: () async {
              when(
                () => tester.mockedApp.mocks.quoteRepository.getRandomQuote(),
              ).thenAnswer(
                (_) async => const QuotableQuote(
                  id: '1',
                  content: 'I know that I know nothing',
                ),
              );

              await tester.tap(
                find.byType(HomeC_QuoteButton),
                pumpAndSettle: true,
              );
            },
            runExpectations: () {
              tester.expect(
                find.text('I know that I know nothing'),
                findsOneWidget,
                reason: 'Should see a random quote displayed',
              );
            },
            expectedEvents: [QuoteEvent_RandomQuote],
            expectedAnalytics: ['Track: Quote: Get Random Quote'],
          );

          await tester.screenshot(
            comment:
                '''If I tap on the random quote button, and there is an error, I should see a snack bar.''',
            takeActions: () async {
              when(
                () => tester.mockedApp.mocks.quoteRepository.getRandomQuote(),
              ).thenThrow(Exception('BOOM'));

              await tester.tap(
                find.byType(HomeC_QuoteButton),
                pumpAndSettle: true,
              );
            },
            runExpectations: () {
              tester
                ..expect(
                  find.text('I know that I know nothing'),
                  findsNothing,
                  reason: 'Should not see the random quote anymore',
                )
                ..expect(
                  find.byType(SnackBar),
                  findsOneWidget,
                  reason: 'Should see an error snack bar',
                )
                ..expect(
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
