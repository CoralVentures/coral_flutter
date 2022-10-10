part of '../widgets.dart';

class CounterText_Connector extends StatelessWidget {
  const CounterText_Connector({super.key});

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
