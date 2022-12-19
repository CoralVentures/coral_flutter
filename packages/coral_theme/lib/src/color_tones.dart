import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CoralThemeColorTones extends Equatable {
  const CoralThemeColorTones({
    required this.primaryTones,
    required this.secondaryTones,
    required this.tertiaryTones,
    required this.errorTones,
    required this.successTones,
    required this.neutralTones,
    required this.neutralVariantTones,
  });

  final CoralColorTones primaryTones;
  final CoralColorTones secondaryTones;
  final CoralColorTones tertiaryTones;
  final CoralColorTones errorTones;
  final CoralColorTones successTones;
  final CoralColorTones neutralTones;
  final CoralColorTones neutralVariantTones;

  @override
  List<Object?> get props => [
        primaryTones,
        secondaryTones,
        tertiaryTones,
        errorTones,
        successTones,
        neutralTones,
        neutralVariantTones,
      ];
}

class CoralColorTones extends Equatable {
  const CoralColorTones({
    required this.tone0,
    required this.tone10,
    required this.tone20,
    required this.tone30,
    required this.tone40,
    required this.tone50,
    required this.tone60,
    required this.tone70,
    required this.tone80,
    required this.tone90,
    required this.tone95,
    required this.tone99,
    required this.tone100,
  });

  final Color tone0;
  final Color tone10;
  final Color tone20;
  final Color tone30;
  final Color tone40;
  final Color tone50;
  final Color tone60;
  final Color tone70;
  final Color tone80;
  final Color tone90;
  final Color tone95;
  final Color tone99;
  final Color tone100;

  @override
  List<Object?> get props => [
        tone0,
        tone10,
        tone20,
        tone30,
        tone40,
        tone50,
        tone60,
        tone70,
        tone80,
        tone90,
        tone95,
        tone99,
        tone100,
      ];
}

// https://m3.material.io/styles/color/the-color-system/tokens
// See baseline color scheme tokens table
//
class CoralColorTones_ColorGetter {
  CoralColorTones_ColorGetter({
    required this.isDarkTheme,
    required this.colorTones,
  });

  final bool isDarkTheme;
  final CoralColorTones colorTones;

  bool get isLightTheme => !isDarkTheme;

  Color get color => isLightTheme ? colorTones.tone40 : colorTones.tone80;
  Color get onColor => isLightTheme ? colorTones.tone100 : colorTones.tone20;
  Color get colorContainer =>
      isLightTheme ? colorTones.tone90 : colorTones.tone30;
  Color get onColorContainer =>
      isLightTheme ? colorTones.tone10 : colorTones.tone90;
  Color get inverseColor =>
      isLightTheme ? colorTones.tone80 : colorTones.tone40;
}

class CoralColorTones_NeutralColorGetter {
  CoralColorTones_NeutralColorGetter({
    required this.isDarkTheme,
    required this.colorTones,
  });

  final bool isDarkTheme;
  final CoralColorTones colorTones;

  bool get isLightTheme => !isDarkTheme;

  // Note: material3 suggests 99 for background, but using 100 instead
  Color get background => isLightTheme ? colorTones.tone100 : colorTones.tone10;
  Color get onBackground =>
      isLightTheme ? colorTones.tone10 : colorTones.tone90;
  Color get surface => isLightTheme ? colorTones.tone99 : colorTones.tone10;
  Color get onSurface => isLightTheme ? colorTones.tone10 : colorTones.tone90;
  Color get inverseSurface =>
      isLightTheme ? colorTones.tone20 : colorTones.tone90;
  Color get onInverseSurface =>
      isLightTheme ? colorTones.tone95 : colorTones.tone20;
  Color get shadow => isLightTheme ? colorTones.tone0 : colorTones.tone0;
}

class CoralColorTones_NeutralVariantColorGetter {
  CoralColorTones_NeutralVariantColorGetter({
    required this.isDarkTheme,
    required this.colorTones,
  });

  final bool isDarkTheme;
  final CoralColorTones colorTones;

  bool get isLightTheme => !isDarkTheme;

  Color get surfaceVariant =>
      isLightTheme ? colorTones.tone90 : colorTones.tone30;
  Color get onSuraceVariant =>
      isLightTheme ? colorTones.tone30 : colorTones.tone80;
  Color get outline => isLightTheme ? colorTones.tone50 : colorTones.tone60;
  Color get outlineVariant =>
      isLightTheme ? colorTones.tone80 : colorTones.tone30;
}
