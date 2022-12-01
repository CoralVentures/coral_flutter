import 'package:flow_example/pages/home/widgets_connector/create_todo_button.dart';
import 'package:flow_example/pages/home/widgets_connector/todo_items.dart';
import 'package:flutter/material.dart';

class Home_Page extends StatelessWidget {
  const Home_Page({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Home_Scaffold();
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
              children: const [
                HomeC_CreateTodoButton(),
                SizedBox(height: 24),
                HomeC_TodoItems(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
