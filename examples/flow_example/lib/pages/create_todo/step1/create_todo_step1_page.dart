import 'package:flow_example/blocs/create_todo/create_todo_bloc.dart';
import 'package:flow_example/pages/create_todo/step1/widgets_connector/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTodoStep1_Page extends StatelessWidget {
  const CreateTodoStep1_Page({
    super.key,
    required this.createTodoBloc,
  });

  final CreateTodoBloc createTodoBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: createTodoBloc,
      child: const CreateTodoStep1_Scaffold(),
    );
  }
}

class CreateTodoStep1_Scaffold extends StatelessWidget {
  const CreateTodoStep1_Scaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SizedBox.expand(
          child: SingleChildScrollView(
            child: CreateTodoStep1C_Form(),
          ),
        ),
      ),
    );
  }
}
