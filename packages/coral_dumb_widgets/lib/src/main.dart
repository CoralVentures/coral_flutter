import 'package:coral_dumb_widgets/coral_dumb_widgets.dart';
import 'package:flutter/material.dart';

export 'route_wrapper.dart';
export 'scaffold_body.dart';
export 'section.dart';
export 'styles.dart';
export 'text.dart';

void registerCoralDumbWidgets({
  required Map<CoralStyle_Color, Color> colorsMap,
  required Map<CoralStyle_Spacing, double> spacingsMap,
  required Map<CoralStyle_Typography, TextStyle> typographyMap,
}) {
  assert(
    colorsMap.values.length == CoralStyle_Color.values.length,
    '''coral_dumb_widgets: colorsMap should include all colors''',
  );
  assert(
    spacingsMap.values.length == CoralStyle_Spacing.values.length,
    '''coral_dumb_widgets: spacingsMap should include all spacings''',
  );
  assert(
    typographyMap.values.length == CoralStyle_Typography.values.length,
    '''coral_dumb_widgets: typographyMap should include all typographies''',
  );

  CoralD_Text.registerWidget(
    colorsMap: colorsMap,
    typographyMap: typographyMap,
  );
  CoralD_Section.registerWidget(
    spacingsMap: spacingsMap,
  );
  CoralD_ScaffoldBody.registerWidget(
    spacingsMap: spacingsMap,
  );
}
