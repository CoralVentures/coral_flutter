import 'package:flutter/material.dart';

import 'assignee_input.dart';
import 'submit_button.dart';

class CreateTodoStep3C_Form extends StatefulWidget {
  const CreateTodoStep3C_Form({super.key});

  @override
  State<CreateTodoStep3C_Form> createState() => _CreateTodoStep3C_FormState();
}

class _CreateTodoStep3C_FormState extends State<CreateTodoStep3C_Form> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CreateTodoStep3C_AssigneeInput(controller: controller),
        CreateTodoStep3C_SubmitButton(controller: controller),
      ],
    );
  }
}
