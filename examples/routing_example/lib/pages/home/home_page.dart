import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routing_example/blocs/counter/counter_bloc.dart';
import 'package:routing_example/pages/home/widget_connectors/counter_text.dart';
import 'package:routing_example/pages/home/widget_connectors/decrement_button.dart';
import 'package:routing_example/pages/home/widget_connectors/go_to_about_button.dart';
import 'package:routing_example/pages/home/widget_connectors/increment_button.dart';
import 'package:routing_example/pages/home/widget_connectors/push_to_about_button.dart';
import 'package:routing_example/pages/home/widget_connectors/title.dart';
import 'package:routing_example/styles/app_spacings.dart';

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
        appBar: AppBar(
          title: const HomeC_Title(),
        ),
        body: SizedBox.expand(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const HomeC_CounterText(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    HomeC_DecrementButton(),
                    SizedBox(width: AppSpacings.small),
                    HomeC_IncrementButton(),
                  ],
                ),
                const HomeC_GoToAboutButton(),
                const HomeC_PushToAboutButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
