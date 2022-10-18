import 'package:data_layer_example/blocs/quote/quote_bloc.dart';
import 'package:data_layer_example/styling/spacings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeC_QuoteText extends StatelessWidget {
  const HomeC_QuoteText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuoteBloc, QuoteState>(
      builder: (context, state) {
        switch (state.quoteStatus) {
          case QuoteStatus.error:
            return const SizedBox();

          case QuoteStatus.inProgress:
            return Container(
              padding: EdgeInsets.all(Spacings.medium),
              child: const CircularProgressIndicator(),
            );

          case QuoteStatus.idle:
            if (state.quote != null) {
              return Container(
                padding: EdgeInsets.all(Spacings.medium),
                child: Text(state.quote?.content ?? ''),
              );
            }
            return const SizedBox();
        }
      },
    );
  }
}
