import 'package:flutter/material.dart';
import 'package:routing_example/l10n/l10n.dart';
import 'package:routing_example/pages/shared/widgets_dumb/title.dart';

class HomeC_Title extends StatelessWidget {
  const HomeC_Title({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.of(context).home_pageTitle;

    return SharedD_Title(
      label: label,
    );
  }
}
