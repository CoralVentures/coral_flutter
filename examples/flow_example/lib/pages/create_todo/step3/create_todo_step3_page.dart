import 'package:flow_example/pages/create_todo/step3/widgets_connector/form.dart';
import 'package:flutter/material.dart';

class CreateTodoStep3_Page extends StatelessWidget {
  const CreateTodoStep3_Page({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CreateTodoStep3_Scaffold();
  }
}

class CreateTodoStep3_Scaffold extends StatelessWidget {
  const CreateTodoStep3_Scaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SizedBox.expand(
          child: SingleChildScrollView(
            child: CreateTodoStep3C_Form(),
          ),
        ),
      ),
    );
  }
}
