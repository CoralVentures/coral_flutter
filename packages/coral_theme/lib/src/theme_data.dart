import 'package:coral_theme/coral_theme.dart';
import 'package:flutter/material.dart';

class CoralThemeData {
  CoralThemeData({
    required this.theme,
  });

  final CoralTheme theme;

  ThemeData get themeData {
    return ThemeData(
      brightness: theme.isDarkTheme ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: theme.colors.background,
      iconTheme: IconThemeData(color: theme.colors.onBackground),
      sliderTheme: SliderThemeData(
        thumbColor: theme.colors.tertiary,
        activeTrackColor: theme.colors.tertiary,
        inactiveTrackColor: theme.colors.tertiaryContainer,
        valueIndicatorColor: theme.colors.tertiaryContainer,
        valueIndicatorTextStyle: theme.typographies.labelMedium
            .copyWith(color: theme.colors.onTertiaryContainer),
      ),
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
