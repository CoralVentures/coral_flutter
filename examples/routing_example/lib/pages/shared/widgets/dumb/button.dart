import 'package:flutter/material.dart';
import '../../../../styles/app_colors.dart';

enum SharedD_ButtonType { primary, success, danger }

class SharedD_Button extends StatelessWidget {
  const SharedD_Button({
    super.key,
    this.buttonType = SharedD_ButtonType.primary,
    required this.onPressed,
    required this.label,
  });

  final SharedD_ButtonType buttonType;
  final VoidCallback? onPressed;
  final String label;

  Color get buttonColor {
    switch (buttonType) {
      case SharedD_ButtonType.primary:
        return AppColors.primary;
      case SharedD_ButtonType.success:
        return AppColors.success;
      case SharedD_ButtonType.danger:
        return AppColors.danger;
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
