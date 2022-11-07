import 'package:data_layer_example/blocs/quote/quote_bloc.dart';
import 'package:data_layer_example/pages/home/widgets_connector/quote_button.dart';
import 'package:data_layer_example/pages/home/widgets_connector/quote_listener.dart';
import 'package:data_layer_example/pages/home/widgets_connector/quote_text.dart';
import 'package:data_layer_example/repositories/quote/quote_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
