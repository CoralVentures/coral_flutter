import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';

class CreateTodoStep3C_AssigneeInput extends StatelessWidget {
  const CreateTodoStep3C_AssigneeInput({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: l10n.createTodoStep3_assignee,
      ),
    );
  }
}
