import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/quote/bloc.dart';
import '../../repositories/quote/repository.dart';
import 'widgets/connector/quote_button.dart';
import 'widgets/connector/quote_listener.dart';
import 'widgets/connector/quote_text.dart';

class Home_Page extends StatelessWidget {
  const Home_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (contextP) {
        final quoteRepository = context.read<QuoteRepository>();
        return QuoteBloc(quoteRepository: quoteRepository);
      },
      child: const Home_Scaffold(),
    );
  }
}

class Home_Scaffold extends StatelessWidget {
  const Home_Scaffold({super.key});
  @override
  Widget build(BuildContext context) {
    return HomeC_QuoteListener(
      child: SafeArea(
        child: Scaffold(
          body: SizedBox.expand(
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  HomeC_QuoteButton(),
                  HomeC_QuoteText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
