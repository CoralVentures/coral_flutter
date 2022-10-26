import 'package:bottom_nav_example/blocs/bottom_nav/bottom_nav_bloc.dart';
import 'package:bottom_nav_example/pages/home/widgets_dumb/scaffold_body.dart';
import 'package:bottom_nav_example/pages/settings/widgets_dumb/scaffold_body.dart';
import 'package:bottom_nav_example/pages/shared/widgets_dumb/fade_up_transition_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LaunchpadC_ScaffoldBody extends StatelessWidget {
  const LaunchpadC_ScaffoldBody({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavBloc = context.watch<BottomNavBloc>();
    final tab = bottomNavBloc.state.tab;

    switch (tab) {
      case BottomNavTab.home:
        return const SharedD_ScaleAndFadeTransitionContainer(
          child: HomeD_ScaffoldBody(),
        );
      case BottomNavTab.settings:
        return const SharedD_ScaleAndFadeTransitionContainer(
          child: SettingsD_ScaffoldBody(),
        );
    }
  }
}
