import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:routing_example/app/app_router.dart';
import 'package:routing_example/blocs/authentication/authentication_bloc.dart';
import 'package:routing_example/pages/login/widget_connectors/login_failed_snackbar.dart';

class LoginC_LoginListener extends StatelessWidget {
  const LoginC_LoginListener({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case AuthenticationStatus.none:
          case AuthenticationStatus.inProgress:
            break; // no-op
          case AuthenticationStatus.authenticated:
            GoRouter.of(context).goNamed(AppRoutes.home.name);
            break;
          case AuthenticationStatus.failed:
            ScaffoldMessenger.of(context).showSnackBar(
              LoginC_LoginFailedSnackbar(),
            );
            break;
        }
      },
      child: child,
    );
  }
}
