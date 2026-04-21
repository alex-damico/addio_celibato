import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,

      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimaryFixed,
        primaryContainer: AppColors.primaryContainer,
        secondary: AppColors.secondary,
        surface: AppColors.background,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryContainer,
          foregroundColor: AppColors.onPrimaryFixed,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),

      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: AppColors.text,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          letterSpacing: 2,
        ),
        labelSmall: TextStyle(
          color: AppColors.text,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
        labelMedium: TextStyle(
          color: AppColors.text,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
        labelLarge: TextStyle(
          color: AppColors.text,
          fontSize: 56,
          height: 0.9,
          fontWeight: FontWeight.w900,
          letterSpacing: -2,
        ),
        bodyMedium: TextStyle(
          color: AppColors.text,
          fontSize: 20,
          height: 1.5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
