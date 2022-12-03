import 'package:coral_dumb_widgets/coral_dumb_widgets.dart';
import 'package:flutter/material.dart';

class CoralD_ScaffoldBody extends StatelessWidget {
  const CoralD_ScaffoldBody({
    super.key,
    required this.children,
    this.stickyWidget,
  });

  final List<Widget> children;
  final Widget? stickyWidget;

  static void registerWidget({
    required Map<CoralStyle_Spacing, double> spacingsMap,
  }) {
    _spacingsMap = spacingsMap;
  }

  static late Map<CoralStyle_Spacing, double> _spacingsMap;

  @override
  Widget build(BuildContext context) {
    final safeBottomPadding = MediaQuery.of(context).padding.bottom;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...children,
                SizedBox(
                  height: _spacingsMap[CoralStyle_Spacing.medium],
                ),
              ],
            ),
          ),
        ),

        /// Sticky widget
        if (stickyWidget != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(),
              stickyWidget!,
              SizedBox(
                height: safeBottomPadding == 0
                    ? _spacingsMap[CoralStyle_Spacing.mediumPlus]
                    : 0,
              ),
            ],
          )
      ],
    );
  }
}
