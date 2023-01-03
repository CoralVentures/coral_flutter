import 'package:flutter/material.dart';

class SharedD_ScaleAndFadeTransitionContainer extends StatefulWidget {
  const SharedD_ScaleAndFadeTransitionContainer({
    super.key,
    required this.child,
    this.skipScaleTransition = false,
    this.skipFadeTransition = false,
  });

  final Widget child;
  final bool skipScaleTransition;
  final bool skipFadeTransition;

  @override
  // ignore: library_private_types_in_public_api
  _SharedD_ScaleAndFadeTransitionContainerState createState() =>
      _SharedD_ScaleAndFadeTransitionContainerState();
}

class _SharedD_ScaleAndFadeTransitionContainerState
    extends State<SharedD_ScaleAndFadeTransitionContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late CurvedAnimation fadeAnimation;
  late CurvedAnimation scaleAnimation;
  late Animation<double> noAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    fadeAnimation = CurvedAnimation(
      curve: Curves.easeInCubic,
      parent: animationController,
    );
    scaleAnimation = CurvedAnimation(
      curve: Curves.easeIn,
      parent: Tween<double>(begin: 0.95, end: 1).animate(animationController),
    );
    noAnimation = Tween<double>(begin: 1, end: 1).animate(animationController);
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SharedD_ScaleAndFadeTransitionContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.child != oldWidget.child) {
      animationController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: widget.skipScaleTransition ? noAnimation : scaleAnimation,
      child: FadeTransition(
        opacity: widget.skipFadeTransition ? noAnimation : fadeAnimation,
        child: widget.child,
      ),
    );
  }
}
