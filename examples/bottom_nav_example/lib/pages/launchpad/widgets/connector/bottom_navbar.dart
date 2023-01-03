import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/bottom_nav/bloc.dart';
import '../../../../l10n/l10n.dart';

class LaunchpadC_BottomNavbar extends StatelessWidget {
  const LaunchpadC_BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavBloc = context.watch<BottomNavBloc>();
    final l10n = AppLocalizations.of(context);

    return BottomNavigationBar(
      currentIndex: bottomNavBloc.state.tab.index,
      onTap: (index) {
        switch (index) {
          case 1:
            bottomNavBloc.add(const BottomNavEvent_ToSettings());
            break;
          default:
            bottomNavBloc.add(const BottomNavEvent_ToHome());
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: l10n.launchpad_home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: l10n.launchpad_settings,
        ),
      ],
    );
  }
}
