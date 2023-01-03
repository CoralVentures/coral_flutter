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
    Home_PageRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const Home_Page(),
      );
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          Home_PageRoute.name,
          path: '/',
        )
      ];
}

/// generated route for
/// [Home_Page]
class Home_PageRoute extends PageRouteInfo<void> {
  const Home_PageRoute()
      : super(
          Home_PageRoute.name,
          path: '/',
        );

  static const String name = 'Home_PageRoute';
}
