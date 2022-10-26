import 'package:bottom_nav_example/blocs/bottom_nav/bottom_nav_bloc.dart';
import 'package:bottom_nav_example/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SharedC_BottomNavbar extends StatelessWidget {
  const SharedC_BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavBloc = context.watch<BottomNavBloc>();
    final l10n = AppLocalizations.of(context);

    return BottomNavigationBar(
      currentIndex: bottomNavBloc.state.tab.index,
      onTap: (tappedIndex) {
        final tappedTab = BottomNavTab.values[tappedIndex];
        final router = GoRouter.of(context);

        switch (tappedTab) {
          case BottomNavTab.home:
            router.go('/home');
            break;
          case BottomNavTab.settings:
            router.go('/settings');
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: l10n.shared_home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: l10n.shared_settings,
        ),
      ],
    );
  }
}
