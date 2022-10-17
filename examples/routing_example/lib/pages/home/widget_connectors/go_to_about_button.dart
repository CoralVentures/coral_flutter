import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:routing_example/app/app_router.dart';
import 'package:routing_example/l10n/l10n.dart';
import 'package:routing_example/pages/shared/widgets_dumb/button.dart';

class HomeC_GoToAboutButton extends StatelessWidget {
  const HomeC_GoToAboutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.of(context).home_goToAboutPage;
    final router = GoRouter.of(context);

    return SharedD_Button(
      label: label,
      onPressed: () => router.goNamed(AppRoutes.about.name),
    );
  }
}
