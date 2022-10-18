import 'package:data_layer_example/blocs/quote/quote_bloc.dart';
import 'package:data_layer_example/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeC_QuoteListener extends StatelessWidget {
  const HomeC_QuoteListener({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuoteBloc, QuoteState>(
      listenWhen: (previous, current) =>
          previous.quoteStatus != current.quoteStatus,
      listener: (context, state) {
        if (state.quoteStatus == QuoteStatus.error) {
          final label = AppLocalizations.of(context).home_getRandomQuoteError;

          ScaffoldMessenger.maybeOf(context)?.showSnackBar(
            SnackBar(
              content: Text(label),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: child,
    );
  }
}
