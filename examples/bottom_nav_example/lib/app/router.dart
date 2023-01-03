// ignore_for_file: unused_import

import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:flutter/material.dart';

import '../pages/home/widgets/dumb/scaffold_body.dart';
import '../pages/launchpad/page.dart';
import '../pages/settings/widgets/dumb/scaffold_body.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: Launchpad_Page,
    ),
  ],
)
class AppRouter extends _$AppRouter {}
