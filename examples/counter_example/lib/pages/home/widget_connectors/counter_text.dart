import 'package:counter_example/blocs/counter/counter_bloc.dart';
import 'package:counter_example/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeC_CounterText extends StatelessWidget {
  const HomeC_CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBloc = context.watch<CounterBloc>();
    final label = AppLocalizations.of(context)
        .counter_count(counterBloc.state.count.toString());
    final theme = Theme.of(context);

    return Text(
      label,
      style: theme.textTheme.displaySmall,
    );
  }
}
