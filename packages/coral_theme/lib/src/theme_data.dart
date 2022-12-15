import 'package:coral_theme/coral_theme.dart';
import 'package:flutter/material.dart';

class CoralThemeData {
  CoralThemeData({
    required CoralThemeColorTones themeColorTones,
    required CoralTypographies typographies,
  })  : _themeColorTones = themeColorTones,
        _typographies = typographies;

  final CoralThemeColorTones _themeColorTones;
  final CoralTypographies _typographies;

  ThemeData get lightTheme {
    final _lightThemeColors =
        CoralColors(isDarkTheme: false, themeColorTones: _themeColorTones);
    final _lightTheme =
        CoralTheme(colors: _lightThemeColors, typographies: _typographies);

    return _getThemeData(_lightTheme);
  }

  ThemeData get darkTheme {
    final _darkThemeColors =
        CoralColors(isDarkTheme: true, themeColorTones: _themeColorTones);
    final _darkTheme =
        CoralTheme(colors: _darkThemeColors, typographies: _typographies);

    return _getThemeData(_darkTheme).copyWith(brightness: Brightness.dark);
  }

  ThemeData _getThemeData(CoralTheme theme) {
    return ThemeData(
      scaffoldBackgroundColor: theme.colors.background,
      iconTheme: IconThemeData(color: theme.colors.onBackground),
      textTheme: TextTheme(
        displayLarge: theme.typographies.displayLarge,
        displayMedium: theme.typographies.displayLarge,
        displaySmall: theme.typographies.displaySmall,
        headlineLarge: theme.typographies.headlineLarge,
        headlineMedium: theme.typographies.headlineMedium,
        headlineSmall: theme.typographies.headlineSmall,
        titleLarge: theme.typographies.titleLarge,
        titleMedium: theme.typographies.titleMedium,
        titleSmall: theme.typographies.titleSmall,
        bodyLarge: theme.typographies.bodyLarge,
        bodyMedium: theme.typographies.bodyMedium,
        bodySmall: theme.typographies.bodySmall,
        labelLarge: theme.typographies.labelLarge,
        labelMedium: theme.typographies.labelMedium,
        labelSmall: theme.typographies.labelSmall,
      ),
      extensions: [
        theme,
      ],
    );
  }
}
