import 'package:biometrics_example/pages/home/widgets_connector/page_title_text.dart';
import 'package:flutter/material.dart';

class Home_Page extends StatelessWidget {
  const Home_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const Home_Scaffold();
  }
}

class Home_Scaffold extends StatelessWidget {
  const Home_Scaffold({super.key});
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SizedBox.expand(
          child: SingleChildScrollView(
            child: Center(
              child: HomeC_PageTitleText(),
            ),
          ),
        ),
      ),
    );
  }
}
