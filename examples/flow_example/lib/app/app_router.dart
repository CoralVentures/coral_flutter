// ignore_for_file: unused_import

import 'package:auto_route/auto_route.dart';
import 'package:flow_example/app/app_flows.dart';
import 'package:flow_example/pages/create_todo/create_todo_flow.dart';
import 'package:flow_example/pages/create_todo/step1/create_todo_step1_page.dart';
import 'package:flow_example/pages/create_todo/step2/create_todo_step2_page.dart';
import 'package:flow_example/pages/create_todo/step3/create_todo_step3_page.dart';
import 'package:flow_example/pages/home/home_page.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

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
