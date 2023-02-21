import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/pages/forgot_password.dart';
import 'package:ontrack_backoffice/pages/home.dart';
import 'package:ontrack_backoffice/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OnTrack Backoffice',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/forgot_password': (context) => ForgotPasswordPage(),
        '/home': (context) => Home(),
      }
    );
  }
}
