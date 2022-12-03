import 'package:coral_dumb_widgets/coral_dumb_widgets.dart';
import 'package:flutter/material.dart';

/// This widget is a container of [children] that you can add padding around.
/// This widget is similar in concept to the html `section` in that it is meant
/// to add a semantic boundary to the developer that this group of widgets is
/// related.
class CoralD_Section extends StatelessWidget {
  const CoralD_Section({
    super.key,
    required this.children,
    required this.paddingLTRB,
  }) : assert(
          paddingLTRB.length == 4,
          'CoralD_Section: paddingLTRB should have four values',
        );

  final List<Widget> children;
  final List<CoralStyle_Spacing> paddingLTRB;

  static void registerWidget({
    required Map<CoralStyle_Spacing, double> spacingsMap,
  }) {
    _spacingsMap = spacingsMap;
  }

  static late Map<CoralStyle_Spacing, double> _spacingsMap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        _spacingsMap[paddingLTRB[0]]!,
        _spacingsMap[paddingLTRB[1]]!,
        _spacingsMap[paddingLTRB[2]]!,
        _spacingsMap[paddingLTRB[3]]!,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}
