import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routing_example/blocs/counter/counter_bloc.dart';
import 'package:routing_example/pages/about/widget_connectors/go_to_home_button.dart';
import 'package:routing_example/pages/about/widget_connectors/title.dart';
import 'package:routing_example/pages/shared/widgets_connector/counter_text.dart';
import 'package:routing_example/pages/shared/widgets_connector/decrement_button.dart';
import 'package:routing_example/pages/shared/widgets_connector/increment_button.dart';
import 'package:routing_example/styles/app_spacings.dart';

class About_Page extends StatelessWidget {
  const About_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: const About_Scaffold(),
    );
  }
}

class About_Scaffold extends StatelessWidget {
  const About_Scaffold({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const AboutC_Title(),
        ),
        body: SizedBox.expand(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SharedC_CounterText(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SharedC_DecrementButton(),
                    SizedBox(width: AppSpacings.small),
                    SharedC_IncrementButton(),
                  ],
                ),
                const AboutC_GoToHomeButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
