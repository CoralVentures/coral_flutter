import 'package:flow_example/blocs/app/app_bloc.dart';
import 'package:flow_example/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeC_CreateTodoButton extends StatelessWidget {
  const HomeC_CreateTodoButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ElevatedButton(
      onPressed: () {
        context.read<AppBloc>().add(const AppEvent_ToCreateTodoFlow());
      },
      child: Text(l10n.home_createTodoItem),
    );
  }
}
