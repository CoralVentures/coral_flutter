import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/quote/bloc.dart';
import '../../../../l10n/l10n.dart';

class HomeC_QuoteButton extends StatelessWidget {
  const HomeC_QuoteButton({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.of(context).home_getRandomQuote;

    return ElevatedButton(
      onPressed: () {
        context.read<QuoteBloc>().add(const QuoteEvent_RandomQuote());
      },
      child: Text(label),
    );
  }
}
