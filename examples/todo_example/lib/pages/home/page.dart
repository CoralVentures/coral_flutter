import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/todos/bloc.dart';
import 'widgets/connector/todo_input.dart';
import 'widgets/connector/todo_items.dart';

class Home_Page extends StatelessWidget {
  const Home_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodosBloc(),
      child: const Home_Scaffold(),
    );
  }
}

class Home_Scaffold extends StatelessWidget {
  const Home_Scaffold({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox.expand(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: HomeC_TodoInput(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: const [
                      SizedBox(height: 8),
                      HomeC_TodoItems(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
