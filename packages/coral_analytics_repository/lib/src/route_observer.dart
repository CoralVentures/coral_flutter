import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CoralAnalyticRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  CoralAnalyticRouteObserver({
    required this.analyticsRepository,
  });

  final CoralAnalyticsRepository? analyticsRepository;

  void _sendScreenView(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings.name != null) {
      analyticsRepository?.screen(
        screenName: route.settings.name!,
      );
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null) {
      _sendScreenView(previousRoute, route);
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _sendScreenView(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);

    if (newRoute != null) {
      _sendScreenView(newRoute, oldRoute);
    }
  }
}
