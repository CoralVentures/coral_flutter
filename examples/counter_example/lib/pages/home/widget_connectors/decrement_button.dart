import 'package:counter_example/blocs/counter/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeC_DecrementButton extends StatelessWidget {
  const HomeC_DecrementButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<CounterBloc>().add(CounterEvent_Decrement());
      },
      child: const Text('Decrement'),
    );
  }
}
