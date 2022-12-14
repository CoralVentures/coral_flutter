import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/bottom_nav/bloc.dart';
import '../../../home/widgets/dumb/scaffold_body.dart';
import '../../../settings/widgets/dumb/scaffold_body.dart';
import '../../../shared/widgets/dumb/scale_and_fade_transition_container.dart';

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
