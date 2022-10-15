import 'package:flutter/material.dart';

class LoginC_LoginFailedSnackbar extends SnackBar {
  // ignore: prefer_const_constructors_in_immutables
  LoginC_LoginFailedSnackbar({
    super.key,
  }) : super(
          content: const Text('Login Failed'),
          backgroundColor: Colors.red,
        );
}
