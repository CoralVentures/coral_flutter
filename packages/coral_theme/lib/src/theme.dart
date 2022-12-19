// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

import 'package:coral_theme/src/color_tones.dart';
import 'package:coral_theme/src/colors.dart';
import 'package:coral_theme/src/spacings.dart';
import 'package:coral_theme/src/typographies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

extension CoralThemeBuildContext on BuildContext {
  CoralTheme get coralTheme => Theme.of(this).extension<CoralTheme>()!;
}

class CoralTheme extends ThemeExtension<CoralTheme> with EquatableMixin {
  CoralTheme({
    required this.colors,
    required this.typographies,
    required this.spacings,
  });

  // ignore: prefer_constructors_over_static_methods
  static CoralTheme fromColorTones({
    required bool isDarkTheme,
    required CoralThemeColorTones themeColorTones,
    required CoralTypographies typographies,
    required CoralSpacings spacings,
  }) {
    final _primary = CoralColorTones_ColorGetter(
      colorTones: themeColorTones.primaryTones,
      isDarkTheme: isDarkTheme,
    );
    final _secondary = CoralColorTones_ColorGetter(
      colorTones: themeColorTones.secondaryTones,
      isDarkTheme: isDarkTheme,
    );
    final _tertiary = CoralColorTones_ColorGetter(
      colorTones: themeColorTones.tertiaryTones,
      isDarkTheme: isDarkTheme,
    );
    final _error = CoralColorTones_ColorGetter(
      colorTones: themeColorTones.errorTones,
      isDarkTheme: isDarkTheme,
    );
    final _success = CoralColorTones_ColorGetter(
      colorTones: themeColorTones.successTones,
      isDarkTheme: isDarkTheme,
    );
    final _neutral = CoralColorTones_NeutralColorGetter(
      colorTones: themeColorTones.neutralTones,
      isDarkTheme: isDarkTheme,
    );
    final _neutralVariant = CoralColorTones_NeutralVariantColorGetter(
      colorTones: themeColorTones.neutralVariantTones,
      isDarkTheme: isDarkTheme,
    );

    final _colors = CoralColors(
      primary: _primary.color,
      onPrimary: _primary.onColor,
      primaryContainer: _primary.colorContainer,
      onPrimaryContainer: _primary.onColorContainer,
      inversePrimary: _primary.inverseColor,
      secondary: _secondary.color,
      onSecondary: _secondary.onColor,
      secondaryContainer: _secondary.colorContainer,
      onSecondaryContainer: _secondary.onColorContainer,
      inverseSecondary: _secondary.inverseColor,
      tertiary: _tertiary.color,
      onTertiary: _tertiary.onColor,
      tertiaryContainer: _tertiary.colorContainer,
      onTertiaryContainer: _tertiary.onColorContainer,
      inverseTertiary: _tertiary.inverseColor,
      error: _error.color,
      onError: _error.onColor,
      errorContainer: _error.colorContainer,
      onErrorContainer: _error.onColorContainer,
      inverseError: _error.inverseColor,
      success: _success.color,
      onSuccess: _success.onColor,
      successContainer: _success.colorContainer,
      onSuccessContainer: _success.onColorContainer,
      inverseSuccess: _success.inverseColor,
      background: _neutral.background,
      onBackground: _neutral.onBackground,
      surface: _neutral.surface,
      onSurface: _neutral.onSurface,
      inverseSurface: _neutral.inverseSurface,
      onInverseSurface: _neutral.onInverseSurface,
      shadow: _neutral.shadow,
      surfaceVariant: _neutralVariant.surfaceVariant,
      onSurfaceVariant: _neutralVariant.onSuraceVariant,
      outline: _neutralVariant.outline,
      outlineVariant: _neutralVariant.outlineVariant,
    );

    final _typographies = CoralTypographies(
      displayLarge:
          typographies.displayLarge.copyWith(color: _colors.onBackground),
      displayMedium:
          typographies.displayMedium.copyWith(color: _colors.onBackground),
      displaySmall:
          typographies.displaySmall.copyWith(color: _colors.onBackground),
      headlineLarge:
          typographies.headlineLarge.copyWith(color: _colors.onBackground),
      headlineMedium:
          typographies.headlineMedium.copyWith(color: _colors.onBackground),
      headlineSmall:
          typographies.headlineSmall.copyWith(color: _colors.onBackground),
      titleLarge: typographies.titleLarge.copyWith(color: _colors.onBackground),
      titleMedium:
          typographies.titleMedium.copyWith(color: _colors.onBackground),
      titleSmall: typographies.titleSmall.copyWith(color: _colors.onBackground),
      bodyLarge: typographies.bodyLarge.copyWith(color: _colors.onBackground),
      bodyMedium: typographies.bodyMedium.copyWith(color: _colors.onBackground),
      bodySmall: typographies.bodySmall.copyWith(color: _colors.onBackground),
      labelLarge: typographies.labelLarge.copyWith(color: _colors.outline),
      labelMedium: typographies.labelMedium.copyWith(color: _colors.outline),
      labelSmall: typographies.labelSmall.copyWith(color: _colors.outline),
    );

    return CoralTheme(
      colors: _colors,
      typographies: _typographies,
      spacings: spacings,
    );
  }

  final CoralColors colors;
  final CoralTypographies typographies;
  final CoralSpacings spacings;

  @override
  ThemeExtension<CoralTheme> copyWith({
    CoralColors? colors,
    CoralTypographies? typographies,
    CoralSpacings? spacings,
  }) {
    return CoralTheme(
      colors: colors ?? this.colors,
      typographies: typographies ?? this.typographies,
      spacings: spacings ?? this.spacings,
    );
  }

  @override
  CoralTheme lerp(ThemeExtension<CoralTheme>? other, double t) {
    if (other is! CoralTheme) return this;
    return CoralTheme(
      colors: colors.lerp(other.colors, t),
      typographies: typographies.lerp(other.typographies, t),
      spacings: spacings.lerp(other.spacings, t),
    );
  }

  @override
  List<Object?> get props => [
        colors,
        typographies,
        spacings,
      ];
}
