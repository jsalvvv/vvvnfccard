import 'package:flutter/material.dart';

class AppTheme {
  // Neon Colors
  static const neonPink = Color(0xFFFF1B8D);
  static const neonBlue = Color(0xFF00E5FF);
  static const neonGreen = Color(0xFF39FF14);

  // Neon Box Decoration
  static final neonBoxDecoration = BoxDecoration(
    color: Colors.black,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(
      color: neonPink,
      width: 2,
    ),
    boxShadow: [
      BoxShadow(
        color: neonPink.withOpacity(0.5),
        blurRadius: 8,
        spreadRadius: 1,
      ),
    ],
  );

  // Neon Text Style
  static TextStyle getNeonTextStyle({
    required Color color,
    required double fontSize,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      shadows: [
        Shadow(
          color: color.withOpacity(0.8),
          blurRadius: 8,
        ),
        Shadow(
          color: color.withOpacity(0.8),
          blurRadius: 16,
        ),
      ],
    );
  }
}