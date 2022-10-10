import 'package:counter_example/blocs/counter/counter_bloc.dart';
import 'package:counter_example/pages/home/widgets.dart';
import 'package:counter_example/styles/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home_Page extends StatelessWidget {
  const Home_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: const Home_Scaffold(),
    );
  }
}

class Home_Scaffold extends StatelessWidget {
  const Home_Scaffold({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox.expand(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CounterText_Connector(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    DecrementBtn_Connector(),
                    SizedBox(width: Spacing.small),
                    IncrementBtn_Connector(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
