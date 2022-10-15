import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:routing_example/app/app_router.dart';
import 'package:routing_example/blocs/authentication/authentication_bloc.dart';

class LoginC_LogoutListener extends StatelessWidget {
  const LoginC_LogoutListener({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listenWhen: (previous, current) =>
          previous.isAuthenticated != current.isAuthenticated,
      listener: (context, state) {
        GoRouter.of(context).goNamed(AppRoutes.login.name);
      },
      child: child,
    );
  }
}
