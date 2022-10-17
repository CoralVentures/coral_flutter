import 'package:double_yield_example/blocs/greetings/greetings_bloc.dart';
import 'package:double_yield_example/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeC_SayHelloButton extends StatelessWidget {
  const HomeC_SayHelloButton({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.of(context).home_triggerSnackBar;
    final greetingsBloc = context.watch<GreetingsBloc>();

    return ElevatedButton(
      onPressed: () => greetingsBloc.add(const GreetingsEvent_SayHello()),
      child: Text(label),
    );
  }
}
