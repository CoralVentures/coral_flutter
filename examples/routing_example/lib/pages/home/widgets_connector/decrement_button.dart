import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routing_example/blocs/counter/counter_bloc.dart';
import 'package:routing_example/l10n/l10n.dart';
import 'package:routing_example/pages/shared/widgets_dumb/button.dart';

class HomeC_DecrementButton extends StatelessWidget {
  const HomeC_DecrementButton({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.of(context).home_decrement;

    return SharedD_Button(
      buttonType: SharedD_ButtonType.danger,
      onPressed: () {
        context.read<CounterBloc>().add(CounterEvent_Decrement());
      },
      label: label,
    );
  }
}
