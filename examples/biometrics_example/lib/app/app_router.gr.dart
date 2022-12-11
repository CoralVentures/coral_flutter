// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

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
    Loading_PageRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const Loading_Page(),
      );
    },
    Login_PageRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const Login_Page(),
      );
    },
    Home_PageRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const Home_Page(),
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
              Loading_PageRoute.name,
              path: 'loading',
              parent: App_FlowsRoute.name,
            ),
            RouteConfig(
              Login_PageRoute.name,
              path: 'login',
              parent: App_FlowsRoute.name,
            ),
            RouteConfig(
              Home_PageRoute.name,
              path: 'home',
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
/// [Loading_Page]
class Loading_PageRoute extends PageRouteInfo<void> {
  const Loading_PageRoute()
      : super(
          Loading_PageRoute.name,
          path: 'loading',
        );

  static const String name = 'Loading_PageRoute';
}

/// generated route for
/// [Login_Page]
class Login_PageRoute extends PageRouteInfo<void> {
  const Login_PageRoute()
      : super(
          Login_PageRoute.name,
          path: 'login',
        );

  static const String name = 'Login_PageRoute';
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
