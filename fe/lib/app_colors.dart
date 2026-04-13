import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFF3FFCA);
  static const Color primaryContainer = Color(0xFFCAFD00);
  static const Color onPrimaryFixed = Color(0xFF3A4A00);
  static const Color secondary = Color(0xFFFF7441);
  static const Color background = Color(0xFF0C0E11);
  static const Color surfaceContainerHigh = Color(0xFF1D2024);
  static const Color surfaceContainer = Color(0xFF171A1D);
  static const Color surfaceContainerHighest = Color(0xFF23262A);
  static const Color headerBackground = Color(0xFF171A1D);

  static const Color text = Color(0xFFCCFF00);
  static const Color onSurfaceVariant = Color(0xFFAAABAF);
  static const Color outline = Color(0xFF747579);
  static const Color outlineVariant = Color(0xFF46484B);
  static const Color tertiary = Color(0xFF00EC3B);
  static const Color primaryFixedDim = Color(0xFFBEEE00);

  // HUD Text Styles
  static const TextStyle hudTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w900,
    fontStyle: FontStyle.italic,
    letterSpacing: -1,
  );

  static const TextStyle hudLabel = TextStyle(
    fontWeight: FontWeight.w900,
    letterSpacing: 2,
    fontSize: 18,
  );
}
