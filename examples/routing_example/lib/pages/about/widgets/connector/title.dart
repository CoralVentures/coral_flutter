import 'package:flutter/material.dart';
import '../../../../l10n/l10n.dart';

class AboutC_Title extends StatelessWidget {
  const AboutC_Title({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.of(context).about_pageTitle;

    return Text(label);
  }
}
