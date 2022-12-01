import 'package:flow_example/blocs/create_todo/create_todo_bloc.dart';
import 'package:flow_example/pages/create_todo/step2/widgets_connector/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTodoStep2_Page extends StatelessWidget {
  const CreateTodoStep2_Page({
    super.key,
    required this.createTodoBloc,
  });

  final CreateTodoBloc createTodoBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: createTodoBloc,
      child: const CreateTodoStep2_Scaffold(),
    );
  }
}

class CreateTodoStep2_Scaffold extends StatelessWidget {
  const CreateTodoStep2_Scaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SizedBox.expand(
          child: SingleChildScrollView(
            child: CreateTodoStep2C_Form(),
          ),
        ),
      ),
    );
  }
}
