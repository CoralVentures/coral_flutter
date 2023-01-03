import 'package:flutter/material.dart';

class SharedD_Title extends StatelessWidget {
  const SharedD_Title({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      label,
      style: theme.textTheme.displaySmall,
    );
  }
}
