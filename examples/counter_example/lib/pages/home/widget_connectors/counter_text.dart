import 'package:counter_example/blocs/counter/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeC_CounterText extends StatelessWidget {
  const HomeC_CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBloc = context.watch<CounterBloc>();
    final theme = Theme.of(context);

    return Text(
      'Count: ${counterBloc.state.count}',
      style: theme.textTheme.displaySmall,
    );
  }
}
