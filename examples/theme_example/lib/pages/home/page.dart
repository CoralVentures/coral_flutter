import 'package:coral_theme/coral_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/counter/bloc.dart';
import 'widgets/connector/counter_text.dart';
import 'widgets/connector/decrement_button.dart';
import 'widgets/connector/increment_button.dart';

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
                const HomeC_CounterText(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const HomeC_DecrementButton(),
                    SizedBox(width: context.coralTheme.spacings.xSmall),
                    const HomeC_IncrementButton(),
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
