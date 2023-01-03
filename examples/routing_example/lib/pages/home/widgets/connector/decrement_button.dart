import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../blocs/counter/bloc.dart';
import '../../../../l10n/l10n.dart';
import '../../../shared/widgets/dumb/button.dart';

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
