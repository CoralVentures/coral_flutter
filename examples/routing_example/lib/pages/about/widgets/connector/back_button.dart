import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../blocs/app/bloc.dart';

class AboutC_BackButton extends StatelessWidget {
  const AboutC_BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BackButton(
      onPressed: () {
        context.read<AppBloc>().add(const AppEvent_ToHomePage());
      },
    );
  }
}
