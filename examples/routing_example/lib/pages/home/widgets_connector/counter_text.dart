import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routing_example/blocs/counter/counter_bloc.dart';
import 'package:routing_example/l10n/l10n.dart';
import 'package:routing_example/pages/shared/widgets_dumb/title.dart';

class HomeC_CounterText extends StatelessWidget {
  const HomeC_CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBloc = context.watch<CounterBloc>();

    final label = AppLocalizations.of(context)
        .home_count(counterBloc.state.count.toString());

    return SharedD_Title(label: label);
  }
}
