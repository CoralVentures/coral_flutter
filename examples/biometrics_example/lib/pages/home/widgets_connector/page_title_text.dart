import 'package:biometrics_example/l10n/l10n.dart';
import 'package:flutter/material.dart';

class HomeC_PageTitleText extends StatelessWidget {
  const HomeC_PageTitleText({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Text(l10n.home_pageTitle);
  }
}
