import 'package:bottom_nav_example/styles/spacing.dart';
import 'package:flutter/material.dart';

class SettingsD_ScaffoldBody extends StatelessWidget {
  const SettingsD_ScaffoldBody({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.medium),
        child: SizedBox(
          width: double.infinity,
          height: 200,
          child: Placeholder(),
        ),
      ),
    );
  }
}
