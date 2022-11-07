import 'package:biometrics_example/blocs/authentication/authentication_bloc.dart';
import 'package:biometrics_example/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginC_BiometricsStatusText extends StatelessWidget {
  const LoginC_BiometricsStatusText({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticationBloc = context.watch<AuthenticationBloc>();
    final l10n = AppLocalizations.of(context);

    return Text(
      l10n.login_biometricsStatus(
        authenticationBloc.state.biometricsStatus.name,
      ),
    );
  }
}
