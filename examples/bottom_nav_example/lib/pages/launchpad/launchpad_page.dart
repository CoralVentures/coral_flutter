import 'package:bottom_nav_example/pages/launchpad/connector_widgets/app_bar.dart';
import 'package:bottom_nav_example/pages/launchpad/connector_widgets/scaffold_body.dart';
import 'package:bottom_nav_example/pages/shared/widgets_connector/bottom_navbar.dart';
import 'package:flutter/material.dart';

class Launchpad_Page extends StatelessWidget {
  const Launchpad_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: LaunchpadC_AppBar(),
      body: LaunchpadC_ScaffoldBody(),
      bottomNavigationBar: SharedC_BottomNavbar(),
    );
  }
}
