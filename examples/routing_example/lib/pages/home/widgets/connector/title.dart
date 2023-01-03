import 'package:flutter/material.dart';
import '../../../../l10n/l10n.dart';

class HomeC_Title extends StatelessWidget {
  const HomeC_Title({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.of(context).home_pageTitle;

    return Text(label);
  }
}
