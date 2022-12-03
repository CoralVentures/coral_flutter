import 'package:coral_dumb_widgets/coral_dumb_widgets.dart';
import 'package:flutter/material.dart';

export 'route_wrapper.dart';
export 'styles.dart';
export 'text.dart';

void registerCoralDumbWidgets({
  required Map<CoralStyle_Colors, Color> colorsMap,
  required Map<CoralStyle_Typography, TextStyle> typographyMap,
}) {
  assert(
    colorsMap.values.length == CoralStyle_Colors.values.length,
    '''coral_dumb_widgets: colorsMap should include all colors''',
  );
  assert(
    typographyMap.values.length == CoralStyle_Typography.values.length,
    '''coral_dumb_widgets: typographyMap should include all typographies''',
  );

  CoralD_Text.registerWidget(
    colorsMap: colorsMap,
    typographyMap: typographyMap,
  );
}
