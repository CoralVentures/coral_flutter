import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoralD_RouteWrapper extends StatelessWidget {
  const CoralD_RouteWrapper({
    super.key,
    required this.page,
    this.safeAreaLTRB = const [true, true, true, true],
    this.canMaybePop = true,
    this.isSafeAreaDark = true,
    this.safeAreaColorOverride,
  }) : assert(
          safeAreaLTRB.length == 4,
          'safeArea should be a list of four doubles, LTRB',
        );

  final Widget page;
  final List<bool> safeAreaLTRB;
  final bool canMaybePop;
  final bool isSafeAreaDark;
  final Color? safeAreaColorOverride;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => canMaybePop,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        /// https://stackoverflow.com/questions/53873270/flutter-background-of-unsafe-area-in-safearea-widget
        value: isSafeAreaDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        child: Container(
          color: safeAreaColorOverride ??
              (isSafeAreaDark ? Colors.black : Colors.white),
          child: SafeArea(
            left: safeAreaLTRB[0],
            top: safeAreaLTRB[1],
            right: safeAreaLTRB[2],
            bottom: safeAreaLTRB[3],
            child: page,
          ),
        ),
      ),
    );
  }
}
