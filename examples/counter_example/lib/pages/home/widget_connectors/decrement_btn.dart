part of '../widgets.dart';

class DecrementBtn_Connector extends StatelessWidget {
  const DecrementBtn_Connector({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<CounterBloc>().add(const CounterEvent_Decrement());
      },
      child: const Text('Decrement'),
    );
  }
}
