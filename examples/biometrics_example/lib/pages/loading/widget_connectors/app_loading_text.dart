import 'package:biometrics_example/app/app_router.dart';
import 'package:biometrics_example/blocs/authentication/authentication_bloc.dart';
import 'package:biometrics_example/l10n/l10n.dart';
import 'package:coral_biometrics_repository/coral_biometrics_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoadingC_AppLoadingText extends StatefulWidget {
  const LoadingC_AppLoadingText({super.key});

  @override
  State<LoadingC_AppLoadingText> createState() =>
      _LoadingC_AppLoadingTextState();
}

class _LoadingC_AppLoadingTextState extends State<LoadingC_AppLoadingText> {
  @override
  void initState() {
    super.initState();

    /// We want to fire the [AuthenticationEvent_BiometricAuthenticationStarted]
    /// event once when the widget loads. However, in `initState` we don't have
    /// access to context yet. The way to get around this is to
    /// `addPostFrameCallback` to run a function one frame after the function
    /// has loaded. It still only happens once, just a frame delayed, but now
    /// you have access to context.
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final l10n = AppLocalizations.of(context);

        context.read<AuthenticationBloc>().add(
              AuthenticationEvent_BiometricAuthenticationStarted(
                authDescription: l10n.loading_authDescription,
              ),
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listenWhen: (previous, current) =>
          previous.biometricsStatus != current.biometricsStatus,
      listener: (context, state) {
        final router = GoRouter.of(context);

        /// We are listening for biometricStatus changes. If it passed, we
        /// redirect the user to the home page. Otherwise, we redirect them to
        /// the login page.
        if (state.biometricsStatus ==
            CoralBiometricsStatus.authenticationPassed) {
          router.goNamed(AppRoutes.home.name);
        } else {
          router.goNamed(AppRoutes.login.name);
        }
      },
      child: Text(l10n.loading_appLoading),
    );
  }
}
