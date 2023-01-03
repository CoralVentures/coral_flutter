import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/quote/bloc.dart';
import '../../../../styles/spacing.dart';

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
            return const CircularProgressIndicator();

          case QuoteStatus.idle:
            if (state.quote != null) {
              return Container(
                padding: const EdgeInsets.all(Spacing.small),
                child: Text(state.quote?.content ?? ''),
              );
            }
            return const SizedBox();
        }
      },
    );
  }
}
