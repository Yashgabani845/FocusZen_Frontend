import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_glow.dart';
import '../../../../core/theme/app_gradients.dart';

class FocusPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isNeutral;

  const FocusPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isNeutral = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        gradient: isNeutral ? null : AppGradients.focusButton,
        color: isNeutral ? AppColors.neutralButton : null,
        borderRadius: BorderRadius.circular(30),
        boxShadow: isNeutral ? null : AppGlow.primaryGlow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onPressed,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
