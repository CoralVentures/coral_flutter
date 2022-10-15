import 'package:flutter/material.dart';

enum SharedD_ButtonType {
  primary,
  danger,
}

class SharedD_Button extends StatelessWidget {
  const SharedD_Button({
    super.key,
    required this.buttonType,
    required this.onPressed,
    required this.label,
  });

  final SharedD_ButtonType buttonType;
  final VoidCallback onPressed;
  final String label;

  Color get buttonColor {
    switch (buttonType) {
      case SharedD_ButtonType.primary:
        return Colors.green;

      case SharedD_ButtonType.danger:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(buttonColor),
      ),
      child: Text(label),
    );
  }
}
