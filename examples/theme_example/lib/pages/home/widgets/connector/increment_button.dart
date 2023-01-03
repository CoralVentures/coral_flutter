import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../blocs/counter/bloc.dart';
import '../../../../l10n/l10n.dart';

class HomeC_IncrementButton extends StatelessWidget {
  const HomeC_IncrementButton({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.of(context).home_increment;

    return ElevatedButton(
      onPressed: () {
        context.read<CounterBloc>().add(CounterEvent_Increment());
      },
      child: Text(label),
    );
  }
}
