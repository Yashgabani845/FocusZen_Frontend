import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppGradients {
  static const LinearGradient focusButton = LinearGradient(
    colors: [AppColors.focusPrimary, AppColors.focusSecondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient focusProgress = LinearGradient(
    colors: [AppColors.focusPrimary, AppColors.focusSecondary],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [AppColors.background, AppColors.surfaceDark],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  static const LinearGradient glassOverlay = LinearGradient(
    colors: [
      Colors.white10,
      Colors.white24,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
