import 'package:flow_example/pages/create_todo/step2/widgets_connector/form.dart';
import 'package:flutter/material.dart';

class CreateTodoStep2_Page extends StatelessWidget {
  const CreateTodoStep2_Page({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CreateTodoStep2_Scaffold();
  }
}

class CreateTodoStep2_Scaffold extends StatelessWidget {
  const CreateTodoStep2_Scaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SizedBox.expand(
          child: SingleChildScrollView(
            child: CreateTodoStep2C_Form(),
          ),
        ),
      ),
    );
  }
}
