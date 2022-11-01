import 'package:biometrics_example/pages/login/widget_connectors/biometrics_status_text.dart';
import 'package:biometrics_example/pages/login/widget_connectors/page_title_text.dart';
import 'package:flutter/material.dart';

class Login_Page extends StatelessWidget {
  const Login_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const Login_Scaffold();
  }
}

class Login_Scaffold extends StatelessWidget {
  const Login_Scaffold({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox.expand(
          child: SingleChildScrollView(
            child: Column(
              children: const [
                LoginC_PageTitleText(),
                LoginC_BiometricsStatusText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
