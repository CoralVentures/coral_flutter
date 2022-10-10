part of '../widgets.dart';

class IncrementBtn_Connector extends StatelessWidget {
  const IncrementBtn_Connector({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<CounterBloc>().add(const CounterEvent_Increment());
      },
      child: const Text('Increment'),
    );
  }
}
