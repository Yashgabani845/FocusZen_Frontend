import 'package:flutter/material.dart';
import 'package:focusappfrontend/theme/app_colors.dart';

class AppGradients {
  static LinearGradient focusButton = LinearGradient(
    colors: [AppColors.focusPrimary, AppColors.focusSecondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient focusProgress = LinearGradient(
    colors: [AppColors.focusPrimary, AppColors.focusSecondary],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static void updateGradients(Color primary, Color secondary) {
    focusButton = LinearGradient(
      colors: [primary, secondary],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    focusProgress = LinearGradient(
      colors: [primary, secondary],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

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
