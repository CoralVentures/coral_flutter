import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../blocs/counter/bloc.dart';
import '../../../../l10n/l10n.dart';

class HomeC_CounterText extends StatelessWidget {
  const HomeC_CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBloc = context.watch<CounterBloc>();
    final label = AppLocalizations.of(context)
        .home_count(counterBloc.state.count.toString());
    final theme = Theme.of(context);

    return Text(
      label,
      style: theme.textTheme.displaySmall,
    );
  }
}
