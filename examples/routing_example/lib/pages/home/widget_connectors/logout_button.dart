import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routing_example/blocs/authentication/authentication_bloc.dart';
import 'package:routing_example/l10n/l10n.dart';
import 'package:routing_example/pages/shared/widgets_dumb/button.dart';

class HomeC_LogoutButton extends StatelessWidget {
  const HomeC_LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.of(context).home_logout;

    return SharedD_Button(
      buttonType: SharedD_ButtonType.primary,
      onPressed: () {
        final authenticationBloc = context.read<AuthenticationBloc>();

        authenticationBloc.add(
          AuthenticationEvent_Logout(),
        );
      },
      label: label,
    );
  }
}
