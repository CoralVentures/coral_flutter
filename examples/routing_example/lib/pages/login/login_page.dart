import 'package:flutter/material.dart';
import 'package:routing_example/pages/login/widget_connectors/login_fail_button.dart';
import 'package:routing_example/pages/login/widget_connectors/login_listener.dart';
import 'package:routing_example/pages/login/widget_connectors/login_success_button.dart';
import 'package:routing_example/pages/login/widget_connectors/title.dart';

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
    return LoginC_LoginListener(
      child: SafeArea(
        child: Scaffold(
          body: SizedBox.expand(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const LoginC_Title(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      LoginC_LoginFailButton(),
                      LoginC_LoginSuccessButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
