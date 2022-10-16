import 'package:counter_example/blocs/counter/counter_bloc.dart';
import 'package:counter_example/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeC_IncrementButton extends StatelessWidget {
  const HomeC_IncrementButton({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.of(context).counter_increment;

    return ElevatedButton(
      onPressed: () {
        context.read<CounterBloc>().add(CounterEvent_Increment());
      },
      child: Text(label),
    );
  }
}
