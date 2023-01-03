import 'package:flutter/material.dart';

class HomeD_TodoInput extends StatefulWidget {
  const HomeD_TodoInput({
    super.key,
    required this.placeholderLabel,
    required this.onSubmitted,
  });

  final String placeholderLabel;
  final ValueSetter<String> onSubmitted;

  @override
  State<HomeD_TodoInput> createState() => _HomeD_TodoInputState();
}

class _HomeD_TodoInputState extends State<HomeD_TodoInput> {
  late TextEditingController textEditingController;
  late FocusNode focusNode;

  @override
  void initState() {
    textEditingController = TextEditingController();
    focusNode = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: textEditingController,
      decoration: InputDecoration(
        labelText: widget.placeholderLabel,
      ),
      onSubmitted: (value) {
        focusNode.unfocus();
        textEditingController.clear();
        widget.onSubmitted(value);
      },
    );
  }
}
