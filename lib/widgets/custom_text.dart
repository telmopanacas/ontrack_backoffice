import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  final TextAlign textAlign;

  const CustomText({Key? key, required this.text, required this.size, required this.color, required this.weight, required this.textAlign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.roboto(
        fontSize: size ,
        color: color,
        fontWeight: weight,
      ),
    );
  }
}
