import 'package:bloc/bloc.dart';
import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:coral_bootstrap/coral_bootstrap.dart';
import 'package:coral_tester/src/mocked_coral_app.dart';
import 'package:mocktail/mocktail.dart';

class CoralTestBlocObserver extends CoralBlocObserver {
  CoralTestBlocObserver({
    required this.mockedApp,
    required this.analyticListeners,
  });

  final MockedCoralApp mockedApp;

  final List<CoralBlocObserverAnalyticListener<dynamic>> analyticListeners;

  /// A list of recently added events by their type
  final List<Type> events = [];

  /// A list of recently added analytics by their name
  final List<String> analytics = [];
  void mockAnalytics() {
    /// Track
    when(
      () => mockedApp.mockAnalyticsRepository.track(
        eventName: any(named: 'eventName'),
        properties: any(named: 'properties'),
        options: any(named: 'options'),
      ),
    ).thenAnswer((invocation) {
      final name = invocation.namedArguments[const Symbol('eventName')];
      analytics.add('Track: $name');
    });

    /// Screen
    when(
      () => mockedApp.mockAnalyticsRepository.screen(
        screenName: any(named: 'screenName'),
        properties: any(named: 'properties'),
      ),
    ).thenAnswer((invocation) {
      final name = invocation.namedArguments[const Symbol('screenName')];
      analytics.add('Screen: $name');
    });

    /// Identify
    when(
      () => mockedApp.mockAnalyticsRepository.identify(
        userId: any(named: 'userId'),
        traits: any(named: 'traits'),
        options: any(named: 'options'),
      ),
    ).thenAnswer((invocation) {
      final name = invocation.namedArguments[const Symbol('userId')];
      analytics.add('Identify: $name');
    });
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);

    if (bloc is Cubit) {
      events.add(bloc.runtimeType);
    }
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);

    createAnalyticsOnEventCallback(
      analyticListeners: analyticListeners,
      analyticsRepository: mockedApp.mockAnalyticsRepository,
    ).call(event);

    events.add(event.runtimeType);
  }
}
