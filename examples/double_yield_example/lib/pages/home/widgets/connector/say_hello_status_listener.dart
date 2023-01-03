import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/greetings/bloc.dart';
import '../../../../l10n/l10n.dart';

class HomeC_SayHelloStatusListener extends StatelessWidget {
  const HomeC_SayHelloStatusListener({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<GreetingsBloc, GreetingsState>(
      listenWhen: (previous, current) =>
          previous.helloStatus != current.helloStatus,
      listener: (context, state) {
        if (state.helloStatus == GreetingsHelloStatus.sayHello) {
          final label = AppLocalizations.of(context).home_helloWorld;

          ScaffoldMessenger.maybeOf(context)?.hideCurrentSnackBar();
          ScaffoldMessenger.maybeOf(context)?.showSnackBar(
            SnackBar(
              content: Text(label),
            ),
          );
        }
      },
      child: child,
    );
  }
}
