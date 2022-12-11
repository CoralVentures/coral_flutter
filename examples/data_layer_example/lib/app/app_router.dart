// ignore_for_file: unused_import

import 'package:auto_route/auto_route.dart';
import 'package:data_layer_example/pages/home/home_page.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      initial: true,
      page: Home_Page,
    )
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
