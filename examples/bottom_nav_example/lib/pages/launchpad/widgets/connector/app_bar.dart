import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/bottom_nav/bloc.dart';
import '../../../home/widgets/connector/app_bar.dart';
import '../../../settings/widgets/connector/app_bar.dart';

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
