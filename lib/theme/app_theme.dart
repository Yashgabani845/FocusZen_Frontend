import 'package:flutter/material.dart';
import 'package:focusappfrontend/theme/app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.focusPrimary,
      fontFamily: 'Inter',
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 32),
        displayMedium: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 24),
        bodyLarge: TextStyle(color: AppColors.textPrimary, fontSize: 16),
        bodyMedium: TextStyle(color: AppColors.textSecondary, fontSize: 14),
      ),
      colorScheme: ColorScheme.dark(
        primary: AppColors.focusPrimary,
        secondary: AppColors.focusSecondary,
        surface: AppColors.surfaceDark,
      ),
    );
  }
}
