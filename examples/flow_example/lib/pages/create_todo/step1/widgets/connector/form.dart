import 'package:flutter/material.dart';

import 'continue_button.dart';
import 'task_input.dart';

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
