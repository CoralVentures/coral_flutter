import 'package:bottom_nav_example/l10n/l10n.dart';
import 'package:flutter/material.dart';

class SettingsC_AppBar extends StatelessWidget {
  const SettingsC_AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.of(context).settings_pageTitle;

    return AppBar(
      title: Text(label),
    );
  }
}
