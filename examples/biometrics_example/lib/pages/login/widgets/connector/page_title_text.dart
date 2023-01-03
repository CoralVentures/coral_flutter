import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';

class LoginC_PageTitleText extends StatelessWidget {
  const LoginC_PageTitleText({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Text(l10n.login_pageTitle);
  }
}
