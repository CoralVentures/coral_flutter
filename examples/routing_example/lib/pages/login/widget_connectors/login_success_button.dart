import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routing_example/blocs/authentication/authentication_bloc.dart';
import 'package:routing_example/pages/shared/widgets_dumb/button.dart';

class LoginC_LoginSuccessButton extends StatelessWidget {
  const LoginC_LoginSuccessButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SharedD_Button(
      buttonType: SharedD_ButtonType.primary,
      onPressed: () {
        final authenticationBloc = context.read<AuthenticationBloc>();

        authenticationBloc.add(
          const AuthenticationEvent_Login(isAuthenticated: true),
        );
      },
      label: 'Login (Success)',
    );
  }
}