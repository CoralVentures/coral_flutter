import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/bottom_nav/bloc.dart';
import 'widgets/connector/app_bar.dart';
import 'widgets/connector/bottom_navbar.dart';
import 'widgets/connector/scaffold_body.dart';

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
