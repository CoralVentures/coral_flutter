import 'package:coral_dumb_widgets/src/styles.dart';
import 'package:flutter/material.dart';

class CoralD_Text extends StatelessWidget {
  const CoralD_Text(
    this.data, {
    super.key,
    this.color = CoralStyle_Colors.neutral1000,
    required this.typography,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
  });

  final String data;
  final CoralStyle_Colors color;
  final CoralStyle_Typography typography;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final String? semanticsLabel;

  static void registerWidget({
    required Map<CoralStyle_Colors, Color> colorsMap,
    required Map<CoralStyle_Typography, TextStyle> typographyMap,
  }) {
    _colorsMap = colorsMap;
    _typographyMap = typographyMap;
  }

  static late Map<CoralStyle_Colors, Color> _colorsMap;
  static late Map<CoralStyle_Typography, TextStyle> _typographyMap;

  TextStyle get _textStyle {
    if (!_typographyMap.containsKey(typography)) {
      throw Exception(
        'coral_dumb_widgets: ${typography.toString()} is not registered',
      );
    }
    final ts = _typographyMap[typography]!;

    if (!_colorsMap.containsKey(color)) {
      throw Exception(
        'coral_dumb_widgets: ${color.toString()} is not registered',
      );
    }
    final c = _colorsMap[color]!;

    return ts.copyWith(color: c);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: _textStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
    );
  }
}
