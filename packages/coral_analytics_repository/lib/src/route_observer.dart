import 'package:auto_route/auto_route.dart';
import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CoralAnalyticRouteObserver extends AutoRouteObserver {
  CoralAnalyticRouteObserver({
    required this.analyticsRepository,
  });

  final CoralAnalyticsRepository? analyticsRepository;

  void _sendScreenView(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // We use widgets ending in _Flow to coordinate pages. Because of this, we
    // do not report _Flow screens and on report _Page screens.
    if (route.settings.name != null && !route.settings.name!.contains('Flow')) {
      analyticsRepository?.screen(
        // auto_route renames _Page to _PageRoute. We strip this off when
        // sending analytics to make it cleaner.
        screenName: route.settings.name!.replaceAll('_PageRoute', ''),
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
