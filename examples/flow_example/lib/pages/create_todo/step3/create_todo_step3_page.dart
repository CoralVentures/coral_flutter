import 'package:flow_example/blocs/create_todo/create_todo_bloc.dart';
import 'package:flow_example/pages/create_todo/step3/widgets_connector/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTodoStep3_Page extends StatelessWidget {
  const CreateTodoStep3_Page({
    super.key,
    required this.createTodoBloc,
  });

  final CreateTodoBloc createTodoBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: createTodoBloc,
      child: const CreateTodoStep3_Scaffold(),
    );
  }
}

class CreateTodoStep3_Scaffold extends StatelessWidget {
  const CreateTodoStep3_Scaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SizedBox.expand(
          child: SingleChildScrollView(
            child: CreateTodoStep3C_Form(),
          ),
        ),
      ),
    );
  }
}
