import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/authentication/bloc.dart';
import '../../../../l10n/l10n.dart';

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

    return Text(l10n.loading_appLoading);
  }
}
