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
    App_FlowsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const App_Flows(),
      );
    },
    Home_PageRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const Home_Page(),
      );
    },
    About_PageRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const About_Page(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          App_FlowsRoute.name,
          path: '/',
          children: [
            RouteConfig(
              Home_PageRoute.name,
              path: 'home',
              parent: App_FlowsRoute.name,
            ),
            RouteConfig(
              About_PageRoute.name,
              path: 'about',
              parent: App_FlowsRoute.name,
            ),
          ],
        )
      ];
}

/// generated route for
/// [App_Flows]
class App_FlowsRoute extends PageRouteInfo<void> {
  const App_FlowsRoute({List<PageRouteInfo>? children})
      : super(
          App_FlowsRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'App_FlowsRoute';
}

/// generated route for
/// [Home_Page]
class Home_PageRoute extends PageRouteInfo<void> {
  const Home_PageRoute()
      : super(
          Home_PageRoute.name,
          path: 'home',
        );

  static const String name = 'Home_PageRoute';
}

/// generated route for
/// [About_Page]
class About_PageRoute extends PageRouteInfo<void> {
  const About_PageRoute()
      : super(
          About_PageRoute.name,
          path: 'about',
        );

  static const String name = 'About_PageRoute';
}
