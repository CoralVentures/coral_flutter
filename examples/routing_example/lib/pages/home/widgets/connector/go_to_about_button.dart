import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../blocs/app/bloc.dart';
import '../../../../l10n/l10n.dart';
import '../../../shared/widgets/dumb/button.dart';

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
