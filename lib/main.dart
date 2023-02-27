import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrack_backoffice/controllers/menu_controller.dart';
import 'package:ontrack_backoffice/pages/forgot_password.dart';
import 'package:ontrack_backoffice/pages/layout.dart';
import 'package:ontrack_backoffice/pages/login_page.dart';
import 'package:ontrack_backoffice/controllers/navigation_controller.dart';
import 'package:ontrack_backoffice/static/colors.dart';

void main() {
  Get.put(ControllerMenu());
  Get.put(NavigationController());
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
      },
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          },
        ),

      ),
    );
  }
}
