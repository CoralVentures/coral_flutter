import 'package:flutter/material.dart';
import 'package:routing_example/pages/home/widget_connectors/logout_button.dart';
import 'package:routing_example/pages/home/widget_connectors/logout_listener.dart';
import 'package:routing_example/pages/home/widget_connectors/title.dart';

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
    return HomeC_LogoutListener(
      child: SafeArea(
        child: Scaffold(
          body: SizedBox.expand(
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  HomeC_Title(),
                  HomeC_LogoutButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
