// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

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
    required CoralTypographies typographies,
  }) : _typographies = typographies;

  final CoralColors colors;
  final CoralSpacings spacings = CoralSpacings();
  final CoralTypographies _typographies;

  CoralTypographies get typographies {
    return CoralTypographies(
      displayLarge:
          _typographies.displayLarge.copyWith(color: colors.onBackground),
      displayMedium:
          _typographies.displayMedium.copyWith(color: colors.onBackground),
      displaySmall:
          _typographies.displaySmall.copyWith(color: colors.onBackground),
      headlineLarge:
          _typographies.headlineLarge.copyWith(color: colors.onBackground),
      headlineMedium:
          _typographies.headlineMedium.copyWith(color: colors.onBackground),
      headlineSmall:
          _typographies.headlineSmall.copyWith(color: colors.onBackground),
      titleLarge: _typographies.titleLarge.copyWith(color: colors.onBackground),
      titleMedium:
          _typographies.titleMedium.copyWith(color: colors.onBackground),
      titleSmall: _typographies.titleSmall.copyWith(color: colors.onBackground),
      bodyLarge: _typographies.bodyLarge.copyWith(color: colors.onBackground),
      bodyMedium: _typographies.bodyMedium.copyWith(color: colors.onBackground),
      bodySmall: _typographies.bodySmall.copyWith(color: colors.onBackground),
      labelLarge: _typographies.labelLarge.copyWith(color: colors.outline),
      labelMedium: _typographies.labelMedium.copyWith(color: colors.outline),
      labelSmall: _typographies.labelSmall.copyWith(color: colors.outline),
    );
  }

  @override
  ThemeExtension<CoralTheme> copyWith({CoralColors? colors}) {
    return CoralTheme(
      colors: colors ?? this.colors,
      typographies: _typographies,
    );
  }

  @override
  CoralTheme lerp(ThemeExtension<CoralTheme>? other, double t) {
    if (other is! CoralTheme) return this;
    return CoralTheme(
      colors: colors.lerp(other.colors, t),
      typographies: typographies.lerp(other.typographies, t),
    );
  }

  @override
  List<Object?> get props => [
        colors,
        typographies,
      ];
}
