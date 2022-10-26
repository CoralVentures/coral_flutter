import 'package:bottom_nav_example/styles/spacing.dart';
import 'package:flutter/material.dart';

class HomeD_ScaffoldBody extends StatelessWidget {
  const HomeD_ScaffoldBody({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.medium),
        child: SizedBox(
          width: double.infinity,
          height: 300,
          child: Placeholder(),
        ),
      ),
    );
  }
}
