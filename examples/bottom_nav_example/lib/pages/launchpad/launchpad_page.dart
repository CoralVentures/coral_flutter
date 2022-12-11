import 'package:bottom_nav_example/blocs/bottom_nav/bottom_nav_bloc.dart';
import 'package:bottom_nav_example/pages/launchpad/widgets_connector/app_bar.dart';
import 'package:bottom_nav_example/pages/launchpad/widgets_connector/bottom_navbar.dart';
import 'package:bottom_nav_example/pages/launchpad/widgets_connector/scaffold_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Launchpad_Page extends StatelessWidget {
  const Launchpad_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBloc(),
      child: const Launchpad_Scaffold(),
    );
  }
}

class Launchpad_Scaffold extends StatelessWidget {
  const Launchpad_Scaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: LaunchpadC_AppBar(),
      body: LaunchpadC_ScaffoldBody(),
      bottomNavigationBar: LaunchpadC_BottomNavbar(),
    );
  }
}
