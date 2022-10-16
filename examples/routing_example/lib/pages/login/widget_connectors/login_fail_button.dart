import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routing_example/blocs/authentication/authentication_bloc.dart';
import 'package:routing_example/l10n/l10n.dart';
import 'package:routing_example/pages/shared/widgets_dumb/button.dart';

class LoginC_LoginFailButton extends StatelessWidget {
  const LoginC_LoginFailButton({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.of(context).login_loginFail;

    return SharedD_Button(
      buttonType: SharedD_ButtonType.danger,
      onPressed: () {
        final authenticationBloc = context.read<AuthenticationBloc>();

        authenticationBloc.add(
          AuthenticationEvent_Login(isAuthenticated: false),
        );
      },
      label: label,
    );
  }
}
