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
    CreateTodo_FlowRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const CreateTodo_Flow(),
      );
    },
    CreateTodoStep1_PageRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const CreateTodoStep1_Page(),
      );
    },
    CreateTodoStep2_PageRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const CreateTodoStep2_Page(),
      );
    },
    CreateTodoStep3_PageRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const CreateTodoStep3_Page(),
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
              CreateTodo_FlowRoute.name,
              path: 'todo/create',
              parent: App_FlowsRoute.name,
              children: [
                RouteConfig(
                  CreateTodoStep1_PageRoute.name,
                  path: '1',
                  parent: CreateTodo_FlowRoute.name,
                ),
                RouteConfig(
                  CreateTodoStep2_PageRoute.name,
                  path: '2',
                  parent: CreateTodo_FlowRoute.name,
                ),
                RouteConfig(
                  CreateTodoStep3_PageRoute.name,
                  path: '3',
                  parent: CreateTodo_FlowRoute.name,
                ),
              ],
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
/// [CreateTodo_Flow]
class CreateTodo_FlowRoute extends PageRouteInfo<void> {
  const CreateTodo_FlowRoute({List<PageRouteInfo>? children})
      : super(
          CreateTodo_FlowRoute.name,
          path: 'todo/create',
          initialChildren: children,
        );

  static const String name = 'CreateTodo_FlowRoute';
}

/// generated route for
/// [CreateTodoStep1_Page]
class CreateTodoStep1_PageRoute extends PageRouteInfo<void> {
  const CreateTodoStep1_PageRoute()
      : super(
          CreateTodoStep1_PageRoute.name,
          path: '1',
        );

  static const String name = 'CreateTodoStep1_PageRoute';
}

/// generated route for
/// [CreateTodoStep2_Page]
class CreateTodoStep2_PageRoute extends PageRouteInfo<void> {
  const CreateTodoStep2_PageRoute()
      : super(
          CreateTodoStep2_PageRoute.name,
          path: '2',
        );

  static const String name = 'CreateTodoStep2_PageRoute';
}

/// generated route for
/// [CreateTodoStep3_Page]
class CreateTodoStep3_PageRoute extends PageRouteInfo<void> {
  const CreateTodoStep3_PageRoute()
      : super(
          CreateTodoStep3_PageRoute.name,
          path: '3',
        );

  static const String name = 'CreateTodoStep3_PageRoute';
}
