import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/greetings/bloc.dart';
import 'widgets/connector/say_hello_button.dart';
import 'widgets/connector/say_hello_status_listener.dart';

class Home_Page extends StatelessWidget {
  const Home_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GreetingsBloc(),
      child: const Home_Scaffold(),
    );
  }
}

class Home_Scaffold extends StatelessWidget {
  const Home_Scaffold({super.key});
  @override
  Widget build(BuildContext context) {
    return const HomeC_SayHelloStatusListener(
      child: SafeArea(
        child: Scaffold(
          body: SizedBox.expand(
            child: SingleChildScrollView(
              child: Center(
                child: HomeC_SayHelloButton(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
