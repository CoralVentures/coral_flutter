import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/authentication/bloc.dart';
import '../../../../l10n/l10n.dart';

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
