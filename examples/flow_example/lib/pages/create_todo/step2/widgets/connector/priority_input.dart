import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';

class CreateTodoStep2C_PriorityInput extends StatelessWidget {
  const CreateTodoStep2C_PriorityInput({
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
        labelText: l10n.createTodoStep2_priority,
      ),
    );
  }
}
