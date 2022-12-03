import 'dart:io';

import 'package:coral_dumb_widgets/coral_dumb_widgets.dart';
import 'package:flutter/material.dart';

enum CoralD_Button_Status {
  enabled,
  inProgress,
  disabled,
}

enum CoralD_Button_Type {
  primaryRegular,
  primarySmall,
  secondaryRegular,
  secondarySmall,
  tertiaryRegular,
  tertiarySmall,
}

class CoralD_Button_Config {
  CoralD_Button_Config({
    required this.labelColor,
    required this.labelTypography,
    required this.loadingIndicatorColor,
    required this.loadingIndicatorSize,
    required this.trailingIconColor,
    required this.trailingIconSpacer,
    required this.padding,
    required this.buttonStyle,
  });

  final CoralStyle_Color labelColor;
  final CoralStyle_Typography labelTypography;
  final CoralStyle_Color loadingIndicatorColor;
  final double loadingIndicatorSize;
  final CoralStyle_Color trailingIconColor;
  final CoralStyle_Spacing trailingIconSpacer;
  final CoralStyle_Spacing padding;
  final ButtonStyle buttonStyle;
}

class CoralD_Button extends StatelessWidget {
  const CoralD_Button({
    super.key,
    required this.buttonType,
    required this.label,
    required this.status,
    required this.onPressed,
    this.trailingIcon,
  });

  final CoralD_Button_Type buttonType;
  final String label;
  final CoralD_Button_Status status;
  final VoidCallback onPressed;
  final IconData? trailingIcon;

  static void registerWidget({
    required Map<CoralD_Button_Type, CoralD_Button_Config> configsMap,
    required Map<CoralStyle_Color, Color> colorsMap,
    required Map<CoralStyle_Spacing, double> spacingsMap,
    required Map<CoralStyle_Typography, TextStyle> typographyMap,
  }) {
    _configsMap = configsMap;
    _colorsMap = colorsMap;
    _spacingsMap = spacingsMap;
    _typographyMap = typographyMap;
  }

  static late Map<CoralD_Button_Type, CoralD_Button_Config> _configsMap;
  static late Map<CoralStyle_Color, Color> _colorsMap;
  static late Map<CoralStyle_Spacing, double> _spacingsMap;
  static late Map<CoralStyle_Typography, TextStyle> _typographyMap;

  CoralD_Button_Config get config {
    return _configsMap[buttonType]!;
  }

  VoidCallback? get onPressedCallback {
    switch (status) {
      case CoralD_Button_Status.enabled:
        return onPressed;
      case CoralD_Button_Status.inProgress:
        return () {};
      case CoralD_Button_Status.disabled:
        return null;
    }
  }

  Widget get loadingIndicator {
    final outerSize = _typographyMap[config.labelTypography]!.fontSize! *
        _typographyMap[config.labelTypography]!.height!;
    return SizedBox(
      height: outerSize,
      width: outerSize,
      child: SizedBox(
        height: config.loadingIndicatorSize,
        width: config.loadingIndicatorSize,
        child: CircularProgressIndicator(
          // Note: This code is only written for tests.
          value: Platform.environment.containsKey('FLUTTER_TEST') ? 0.75 : null,
          color: _colorsMap[config.loadingIndicatorColor],
          strokeWidth: 3,
        ),
      ),
    );
  }

  Widget get textRow {
    return IntrinsicWidth(
      child: Row(
        children: [
          Expanded(
            child: CoralD_Text(
              label,
              color: config.labelColor,
              typography: config.labelTypography,
              overflow: TextOverflow.visible,
            ),
          ),
          if (trailingIcon != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: _spacingsMap[config.trailingIconSpacer],
                ),
                Icon(
                  trailingIcon,
                  color: _colorsMap[config.trailingIconColor],
                  size: _typographyMap[config.labelTypography]!.fontSize! *
                      _typographyMap[config.labelTypography]!.height!,
                ),
              ],
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: config.buttonStyle,
      onPressed: onPressedCallback,
      child: Padding(
        padding: EdgeInsets.all(_spacingsMap[config.padding]!),
        child: status == CoralD_Button_Status.inProgress
            ? loadingIndicator
            : textRow,
      ),
    );
  }
}
