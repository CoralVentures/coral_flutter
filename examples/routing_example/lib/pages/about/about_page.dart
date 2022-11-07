import 'package:flutter/material.dart';
import 'package:routing_example/pages/about/widgets_connector/go_to_home_button.dart';
import 'package:routing_example/pages/about/widgets_connector/title.dart';

class About_Page extends StatelessWidget {
  const About_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const About_Scaffold();
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
        body: const SizedBox.expand(
          child: SingleChildScrollView(
            child: Center(
              child: AboutC_GoToHomeButton(),
            ),
          ),
        ),
      ),
    );
  }
}
