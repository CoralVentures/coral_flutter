import 'package:flow_example/pages/create_todo/step1/widgets_connector/continue_button.dart';
import 'package:flow_example/pages/create_todo/step1/widgets_connector/task_input.dart';
import 'package:flutter/material.dart';

class CreateTodoStep1C_Form extends StatefulWidget {
  const CreateTodoStep1C_Form({super.key});

  @override
  State<CreateTodoStep1C_Form> createState() => _CreateTodoStep1C_FormState();
}

class _CreateTodoStep1C_FormState extends State<CreateTodoStep1C_Form> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CreateTodoStep1C_TaskInput(controller: controller),
        CreateTodoStep1C_ContinueButton(controller: controller),
      ],
    );
  }
}
