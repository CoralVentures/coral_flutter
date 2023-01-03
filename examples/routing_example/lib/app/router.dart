// ignore_for_file: unused_import

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../pages/about/page.dart';
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
          path: 'about',
          page: About_Page,
        )
      ],
    )
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
