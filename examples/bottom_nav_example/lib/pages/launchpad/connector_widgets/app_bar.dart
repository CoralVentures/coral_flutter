import 'package:bottom_nav_example/blocs/bottom_nav/bottom_nav_bloc.dart';
import 'package:bottom_nav_example/pages/home/widgets_connector/app_bar.dart';
import 'package:bottom_nav_example/pages/settings/widgets_connector/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LaunchpadC_AppBar extends StatelessWidget implements PreferredSizeWidget {
  const LaunchpadC_AppBar({super.key});

  @override
  Size get preferredSize => const Size(
        double.infinity,
        kToolbarHeight,
      );

  @override
  Widget build(BuildContext context) {
    final bottomNavBloc = context.watch<BottomNavBloc>();
    final tab = bottomNavBloc.state.tab;

    switch (tab) {
      case BottomNavTab.home:
        return const HomeC_AppBar();
      case BottomNavTab.settings:
        return const SettingsC_AppBar();
    }
  }
}
