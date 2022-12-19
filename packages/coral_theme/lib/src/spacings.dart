import 'dart:ui';

import 'package:equatable/equatable.dart';

class CoralSpacings extends Equatable {
  const CoralSpacings({
    required this.none,
    required this.xxxSmall,
    required this.xxSmall,
    required this.xSmall,
    required this.small,
    required this.medium,
    required this.large,
    required this.xLarge,
    required this.xxLarge,
    required this.xxxLarge,
  });

  // ignore: prefer_constructors_over_static_methods
  static CoralSpacings withDefaults() {
    return const CoralSpacings(
      none: 0,
      xxxSmall: 2,
      xxSmall: 4,
      xSmall: 8,
      small: 12,
      medium: 16,
      large: 24,
      xLarge: 32,
      xxLarge: 40,
      xxxLarge: 48,
    );
  }

  final double none;
  final double xxxSmall;
  final double xxSmall;
  final double xSmall;
  final double small;
  final double medium;
  final double large;
  final double xLarge;
  final double xxLarge;
  final double xxxLarge;

  CoralSpacings lerp(CoralSpacings? other, double t) {
    if (other is! CoralSpacings) return this;
    return CoralSpacings(
      none: lerpDouble(none, other.none, t)!,
      xxxSmall: lerpDouble(xxxSmall, other.xxxSmall, t)!,
      xxSmall: lerpDouble(xxSmall, other.xxSmall, t)!,
      xSmall: lerpDouble(xSmall, other.xSmall, t)!,
      small: lerpDouble(small, other.small, t)!,
      medium: lerpDouble(medium, other.medium, t)!,
      large: lerpDouble(large, other.large, t)!,
      xLarge: lerpDouble(xLarge, other.xLarge, t)!,
      xxLarge: lerpDouble(xxLarge, other.xxLarge, t)!,
      xxxLarge: lerpDouble(xxxLarge, other.xxxLarge, t)!,
    );
  }

  @override
  List<Object?> get props => [
        none,
        xxxSmall,
        xxSmall,
        xSmall,
        small,
        medium,
        large,
        xLarge,
        xxLarge,
        xxxLarge,
      ];
}
