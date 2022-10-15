import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:routing_example/app/app_router.dart';
import 'package:routing_example/blocs/authentication/authentication_bloc.dart';

class HomeC_LogoutListener extends StatelessWidget {
  const HomeC_LogoutListener({
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
          case AuthenticationStatus.inProgress:
          case AuthenticationStatus.authenticated:
          case AuthenticationStatus.failed:
            break; // no-op

          case AuthenticationStatus.none:
            GoRouter.of(context).goNamed(AppRoutes.login.name);
            break;
        }
      },
      child: child,
    );
  }
}
