import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CoralColors extends Equatable {
  CoralColors({
    required this.isDarkTheme,
    required this.themeColorTones,
  })  : _primary = CoralColorGetter(
          colorTones: themeColorTones.primaryTones,
          isDarkTheme: isDarkTheme,
        ),
        _secondary = CoralColorGetter(
          colorTones: themeColorTones.secondaryTones,
          isDarkTheme: isDarkTheme,
        ),
        _tertiary = CoralColorGetter(
          colorTones: themeColorTones.tertiaryTones,
          isDarkTheme: isDarkTheme,
        ),
        _error = CoralColorGetter(
          colorTones: themeColorTones.errorTones,
          isDarkTheme: isDarkTheme,
        ),
        _success = CoralColorGetter(
          colorTones: themeColorTones.successTones,
          isDarkTheme: isDarkTheme,
        ),
        _neutral = CoralNeutralColorGetter(
          colorTones: themeColorTones.neutralTones,
          isDarkTheme: isDarkTheme,
        ),
        _neutralVariant = CoralNeutralVariantColorGetter(
          colorTones: themeColorTones.neutralVariantTones,
          isDarkTheme: isDarkTheme,
        );

  final bool isDarkTheme;
  final CoralThemeColorTones themeColorTones;

  final CoralColorGetter _primary;
  final CoralColorGetter _secondary;
  final CoralColorGetter _tertiary;
  final CoralColorGetter _error;
  final CoralColorGetter _success;
  final CoralNeutralColorGetter _neutral;
  final CoralNeutralVariantColorGetter _neutralVariant;

  Color get primary => _primary.color;
  Color get onPrimary => _primary.onColor;
  Color get primaryContainer => _primary.colorContainer;
  Color get onPrimaryContainer => _primary.onColorContainer;
  Color get inversePrimary => _primary.inverseColor;

  Color get secondary => _secondary.color;
  Color get onSecondary => _secondary.onColor;
  Color get secondaryContainer => _secondary.colorContainer;
  Color get onSecondaryContainer => _secondary.onColorContainer;
  Color get inverseSecondary => _secondary.inverseColor;

  Color get tertiary => _tertiary.color;
  Color get onTertiary => _tertiary.onColor;
  Color get tertiaryContainer => _tertiary.colorContainer;
  Color get onTertiaryContainer => _tertiary.onColorContainer;
  Color get inverseTertiary => _tertiary.inverseColor;

  Color get error => _error.color;
  Color get onError => _error.onColor;
  Color get errorContainer => _error.colorContainer;
  Color get onErrorContainer => _error.onColorContainer;
  Color get inverseError => _error.inverseColor;

  Color get success => _success.color;
  Color get onSuccess => _success.onColor;
  Color get successContainer => _success.colorContainer;
  Color get onSuccessContainer => _success.onColorContainer;
  Color get inverseSuccess => _success.inverseColor;

  Color get background => _neutral.background;
  Color get onBackground => _neutral.onBackground;
  Color get surface => _neutral.surface;
  Color get onSurface => _neutral.onSurface;
  Color get inverseSurface => _neutral.inverseSurface;
  Color get onInverseSurface => _neutral.onInverseSurface;
  Color get shadow => _neutral.shadow;

  Color get surfaceVariant => _neutralVariant.surfaceVariant;
  Color get onSurfaceVariant => _neutralVariant.onSuraceVariant;
  Color get outline => _neutralVariant.outline;
  Color get outlineVariant => _neutralVariant.outlineVariant;

  CoralColors lerp(CoralColors? other, double t) {
    if (other is! CoralColors) return this;
    return CoralColors(
      isDarkTheme: other.isDarkTheme,
      themeColorTones: themeColorTones.lerp(other.themeColorTones, t),
    );
  }

  @override
  List<Object?> get props => [
        isDarkTheme,
        themeColorTones,
      ];
}

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

  CoralThemeColorTones lerp(CoralThemeColorTones? other, double t) {
    if (other is! CoralThemeColorTones) return this;
    return CoralThemeColorTones(
      primaryTones: primaryTones.lerp(other.primaryTones, t),
      secondaryTones: secondaryTones.lerp(other.secondaryTones, t),
      tertiaryTones: tertiaryTones.lerp(other.tertiaryTones, t),
      errorTones: errorTones.lerp(other.errorTones, t),
      successTones: successTones.lerp(other.successTones, t),
      neutralTones: neutralTones.lerp(other.neutralTones, t),
      neutralVariantTones:
          neutralVariantTones.lerp(other.neutralVariantTones, t),
    );
  }

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

  CoralColorTones lerp(CoralColorTones? other, double t) {
    if (other is! CoralColorTones) return this;
    return CoralColorTones(
      tone0: Color.lerp(tone0, other.tone0, t)!,
      tone10: Color.lerp(tone10, other.tone10, t)!,
      tone20: Color.lerp(tone20, other.tone20, t)!,
      tone30: Color.lerp(tone30, other.tone30, t)!,
      tone40: Color.lerp(tone40, other.tone40, t)!,
      tone50: Color.lerp(tone50, other.tone50, t)!,
      tone60: Color.lerp(tone60, other.tone60, t)!,
      tone70: Color.lerp(tone70, other.tone70, t)!,
      tone80: Color.lerp(tone80, other.tone80, t)!,
      tone90: Color.lerp(tone90, other.tone90, t)!,
      tone95: Color.lerp(tone95, other.tone95, t)!,
      tone99: Color.lerp(tone99, other.tone99, t)!,
      tone100: Color.lerp(tone100, other.tone100, t)!,
    );
  }

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
class CoralColorGetter {
  CoralColorGetter({
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

class CoralNeutralColorGetter {
  CoralNeutralColorGetter({
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

class CoralNeutralVariantColorGetter {
  CoralNeutralVariantColorGetter({
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
