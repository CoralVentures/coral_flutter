// ignore_for_file: unused_import

import 'package:auto_route/auto_route.dart';
import 'package:biometrics_example/app/app_flows.dart';
import 'package:biometrics_example/pages/home/home_page.dart';
import 'package:biometrics_example/pages/loading/loading_page.dart';
import 'package:biometrics_example/pages/login/login_page.dart';
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
