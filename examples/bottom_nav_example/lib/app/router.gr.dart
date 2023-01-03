// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    Launchpad_PageRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const Launchpad_Page(),
      );
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          Launchpad_PageRoute.name,
          path: '/',
        )
      ];
}

/// generated route for
/// [Launchpad_Page]
class Launchpad_PageRoute extends PageRouteInfo<void> {
  const Launchpad_PageRoute()
      : super(
          Launchpad_PageRoute.name,
          path: '/',
        );

  static const String name = 'Launchpad_PageRoute';
}
