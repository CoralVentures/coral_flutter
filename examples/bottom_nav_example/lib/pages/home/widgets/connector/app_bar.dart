import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';

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
