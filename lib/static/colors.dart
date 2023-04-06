import 'package:flutter/material.dart';

List<Color> coresUCCards = [
  Color(0xFFDB592A),
  Color(0xFFFFCE5D),
  Color(0xFF7CFF6D),
  Color(0xFF7BFFD2),
  Color(0xFFAD71FF),
  Color(0xFFFF749B),
];

final MaterialColor primarySwatch = MaterialColor(
  primary.value,
  <int, Color> {
    50:  primary.withOpacity(0.1),
    100: primary.withOpacity(0.2),
    200: primary.withOpacity(0.3),
    300: primary.withOpacity(0.4),
    400: primary.withOpacity(0.5),
    500: primary.withOpacity(0.6),
    600: primary.withOpacity(0.7),
    700: primary.withOpacity(0.8),
    800: primary.withOpacity(0.9),
    900: primary.withOpacity(1),
  }
);

Color loginButtonColor = Color(0xFF2E2E40);
Color background = Colors.brown[50]!;
Color primary = Color(0xFFCA0944);
Color light = Color(0xFFF7F8FC);
Color lightGrey = Color(0xFFA4A6B3);
//Color dark = Color(0xFF363740);
Color active = Color(0xFF3C19C0);
Color appBarPages = Colors.black; // Color(0xFF8A8A8A)