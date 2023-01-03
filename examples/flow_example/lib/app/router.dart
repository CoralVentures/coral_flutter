// ignore_for_file: unused_import

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../pages/create_todo/flow.dart';
import '../pages/create_todo/step1/page.dart';
import '../pages/create_todo/step2/page.dart';
import '../pages/create_todo/step3/page.dart';
import '../pages/home/page.dart';
import 'flows.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      initial: true,
      page: App_Flows,
      children: [
        AutoRoute(
          path: 'home',
          page: Home_Page,
        ),
        AutoRoute(
          path: 'todo/create',
          page: CreateTodo_Flow,
          children: [
            AutoRoute(
              path: '1',
              page: CreateTodoStep1_Page,
            ),
            AutoRoute(
              path: '2',
              page: CreateTodoStep2_Page,
            ),
            AutoRoute(
              path: '3',
              page: CreateTodoStep3_Page,
            ),
          ],
        )
      ],
    )
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
