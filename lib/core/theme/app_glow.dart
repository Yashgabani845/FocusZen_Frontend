// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppGlow {
  static List<BoxShadow> primaryGlow = [
    BoxShadow(
      color: AppColors.focusPrimary.withOpacity(0.4),
      blurRadius: 20,
      spreadRadius: 2,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> intenseGlow = [
    BoxShadow(
      color: AppColors.focusPrimary.withOpacity(0.6),
      blurRadius: 30,
      spreadRadius: 8,
      offset: const Offset(0, 0),
    ),
  ];

  static List<BoxShadow> ambientGlow(Color glowColor) => [
    BoxShadow(
      color: glowColor.withOpacity(0.3),
      blurRadius: 15,
      spreadRadius: 0,
      offset: const Offset(0, 4),
    ),
  ];
}
