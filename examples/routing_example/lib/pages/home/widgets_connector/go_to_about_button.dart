import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routing_example/blocs/app/app_bloc.dart';
import 'package:routing_example/l10n/l10n.dart';
import 'package:routing_example/pages/shared/widgets_dumb/button.dart';

class HomeC_GoToAboutButton extends StatelessWidget {
  const HomeC_GoToAboutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.of(context).home_goToAboutPage;

    return SharedD_Button(
      label: label,
      onPressed: () =>
          context.read<AppBloc>().add(const AppEvent_ToAboutPage()),
    );
  }
}
