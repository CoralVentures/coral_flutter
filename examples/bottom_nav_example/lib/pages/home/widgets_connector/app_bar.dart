import 'package:bottom_nav_example/l10n/l10n.dart';
import 'package:flutter/material.dart';

class HomeC_AppBar extends StatelessWidget {
  const HomeC_AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.of(context).home_pageTitle;

    return AppBar(
      title: Text(label),
    );
  }
}
