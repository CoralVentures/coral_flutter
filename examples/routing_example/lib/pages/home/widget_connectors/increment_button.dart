import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routing_example/blocs/counter/counter_bloc.dart';
import 'package:routing_example/l10n/l10n.dart';
import 'package:routing_example/pages/shared/widgets_dumb/button.dart';

class HomeC_IncrementButton extends StatelessWidget {
  const HomeC_IncrementButton({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.of(context).home_increment;

    return SharedD_Button(
      buttonType: SharedD_ButtonType.success,
      onPressed: () {
        context.read<CounterBloc>().add(CounterEvent_Increment());
      },
      label: label,
    );
  }
}
