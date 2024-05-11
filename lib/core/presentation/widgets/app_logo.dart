import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLogo extends StatelessWidget {
  final bool large;
  const AppLogo({super.key, required this.large});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          'rank',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: large ? 60 : 40,
          ),
        ),
        Text(
          'AI',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: large ? 40 : 26,
          ),
        ),
      ],
    );
  }
}
