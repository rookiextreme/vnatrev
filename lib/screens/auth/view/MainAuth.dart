import 'package:flutter/material.dart';
import 'package:vnat/screens/auth/view/subview/LoginForm.dart';

class MainAuth extends StatelessWidget {
  static const route = 'main-auth';

  const MainAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: LoginForm(),
      ),
    );
  }
}
