import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class CoralTypographies extends ThemeExtension<CoralTypographies> {
  CoralTypographies({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
  });

  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;

  @override
  CoralTypographies copyWith({
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
  }) {
    return CoralTypographies(
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      displaySmall: displaySmall ?? this.displaySmall,
      headlineLarge: headlineLarge ?? this.headlineLarge,
      headlineMedium: headlineMedium ?? this.headlineMedium,
      headlineSmall: headlineSmall ?? this.headlineSmall,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      labelLarge: labelLarge ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,
    );
  }

  @override
  CoralTypographies lerp(
    ThemeExtension<CoralTypographies>? other,
    double t,
  ) {
    if (other is! CoralTypographies) return this;
    return CoralTypographies(
      displayLarge: TextStyle.lerp(displayLarge, other.displayLarge, t)!,
      displayMedium: TextStyle.lerp(displayMedium, other.displayMedium, t)!,
      displaySmall: TextStyle.lerp(displaySmall, other.displaySmall, t)!,
      headlineLarge: TextStyle.lerp(headlineLarge, other.headlineLarge, t)!,
      headlineMedium: TextStyle.lerp(headlineMedium, other.headlineMedium, t)!,
      headlineSmall: TextStyle.lerp(headlineSmall, other.headlineSmall, t)!,
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t)!,
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t)!,
      titleSmall: TextStyle.lerp(titleSmall, other.titleSmall, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
      labelLarge: TextStyle.lerp(labelLarge, other.labelLarge, t)!,
      labelMedium: TextStyle.lerp(labelMedium, other.labelMedium, t)!,
      labelSmall: TextStyle.lerp(labelSmall, other.labelSmall, t)!,
    );
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CoralTypographies &&
            const DeepCollectionEquality()
                .equals(displayLarge, other.displayLarge) &&
            const DeepCollectionEquality()
                .equals(displayMedium, other.displayMedium) &&
            const DeepCollectionEquality()
                .equals(displaySmall, other.displaySmall) &&
            const DeepCollectionEquality()
                .equals(headlineLarge, other.headlineLarge) &&
            const DeepCollectionEquality()
                .equals(headlineMedium, other.headlineMedium) &&
            const DeepCollectionEquality()
                .equals(headlineSmall, other.headlineSmall) &&
            const DeepCollectionEquality()
                .equals(titleLarge, other.titleLarge) &&
            const DeepCollectionEquality()
                .equals(titleMedium, other.titleMedium) &&
            const DeepCollectionEquality()
                .equals(titleSmall, other.titleSmall) &&
            const DeepCollectionEquality().equals(bodyLarge, other.bodyLarge) &&
            const DeepCollectionEquality()
                .equals(bodyMedium, other.bodyMedium) &&
            const DeepCollectionEquality().equals(bodySmall, other.bodySmall) &&
            const DeepCollectionEquality()
                .equals(labelLarge, other.labelLarge) &&
            const DeepCollectionEquality()
                .equals(labelMedium, other.labelMedium) &&
            const DeepCollectionEquality()
                .equals(labelSmall, other.labelSmall));
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode {
    return Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(displayLarge),
      const DeepCollectionEquality().hash(displayMedium),
      const DeepCollectionEquality().hash(displaySmall),
      const DeepCollectionEquality().hash(headlineLarge),
      const DeepCollectionEquality().hash(headlineMedium),
      const DeepCollectionEquality().hash(headlineSmall),
      const DeepCollectionEquality().hash(titleLarge),
      const DeepCollectionEquality().hash(titleMedium),
      const DeepCollectionEquality().hash(titleSmall),
      const DeepCollectionEquality().hash(bodyLarge),
      const DeepCollectionEquality().hash(bodyMedium),
      const DeepCollectionEquality().hash(bodySmall),
      const DeepCollectionEquality().hash(labelLarge),
      const DeepCollectionEquality().hash(labelMedium),
      const DeepCollectionEquality().hash(labelSmall),
    );
  }
}
