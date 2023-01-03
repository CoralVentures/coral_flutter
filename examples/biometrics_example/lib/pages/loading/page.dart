import 'package:flutter/material.dart';

import 'widgets/connector/app_loading_text.dart';

class Loading_Page extends StatelessWidget {
  const Loading_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const Loading_Scaffold();
  }
}

class Loading_Scaffold extends StatelessWidget {
  const Loading_Scaffold({super.key});
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SizedBox.expand(
          child: SingleChildScrollView(
            child: Center(
              child: LoadingC_AppLoadingText(),
            ),
          ),
        ),
      ),
    );
  }
}
