import 'package:flow_example/pages/create_todo/step2/widgets_connector/continue_button.dart';
import 'package:flow_example/pages/create_todo/step2/widgets_connector/priority_input.dart';
import 'package:flutter/material.dart';

class CreateTodoStep2C_Form extends StatefulWidget {
  const CreateTodoStep2C_Form({super.key});

  @override
  State<CreateTodoStep2C_Form> createState() => _CreateTodoStep2C_FormState();
}

class _CreateTodoStep2C_FormState extends State<CreateTodoStep2C_Form> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CreateTodoStep2C_PriorityInput(controller: controller),
        CreateTodoStep2C_ContinueButton(controller: controller),
      ],
    );
  }
}
