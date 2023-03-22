import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Forgot Password Page', style: TextStyle(fontSize: 24, color: Colors.black), textAlign: TextAlign.center),
      ),
    );
  }
}
