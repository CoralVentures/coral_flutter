// ignore_for_file: unused_import

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../pages/home/page.dart';
import '../pages/loading/page.dart';
import '../pages/login/page.dart';
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
          path: 'loading',
          page: Loading_Page,
        ),
        AutoRoute(
          path: 'login',
          page: Login_Page,
        ),
        AutoRoute(
          path: 'home',
          page: Home_Page,
        ),
      ],
    )
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
