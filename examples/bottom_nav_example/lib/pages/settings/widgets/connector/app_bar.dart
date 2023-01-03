import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';

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
