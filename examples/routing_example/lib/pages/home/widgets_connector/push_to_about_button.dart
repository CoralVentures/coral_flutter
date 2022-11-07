import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:routing_example/app/app_builder.dart';
import 'package:routing_example/l10n/l10n.dart';
import 'package:routing_example/pages/shared/widgets_dumb/button.dart';

class HomeC_PushToAboutButton extends StatelessWidget {
  const HomeC_PushToAboutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.of(context).home_pushToAboutPage;
    final router = GoRouter.of(context);

    return SharedD_Button(
      label: label,
      onPressed: () => router.pushNamed(AppRoutes.about.name),
    );
  }
}
