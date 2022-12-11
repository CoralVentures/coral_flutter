// ignore_for_file: unused_import

import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:bottom_nav_example/pages/home/widgets_dumb/scaffold_body.dart';
import 'package:bottom_nav_example/pages/launchpad/launchpad_page.dart';
import 'package:bottom_nav_example/pages/settings/widgets_dumb/scaffold_body.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: Launchpad_Page,
    ),
  ],
)
class AppRouter extends _$AppRouter {}
