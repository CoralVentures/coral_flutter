import 'package:flutter/material.dart';
import 'widgets/connector/back_button.dart';
import 'widgets/connector/title.dart';

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
          leading: const AboutC_BackButton(),
        ),
      ),
    );
  }
}
