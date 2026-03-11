import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_glow.dart';

class CircularFocusProgress extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final Widget? child;
  final double size;

  const CircularFocusProgress({
    super.key,
    required this.progress,
    this.child,
    this.size = 280,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: AppGlow.primaryGlow,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: 1.0,
            strokeWidth: 8,
            valueColor: const AlwaysStoppedAnimation(AppColors.surfaceDark),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: progress),
            duration: const Duration(milliseconds: 500),
            builder: (context, value, _) {
              return CircularProgressIndicator(
                value: value,
                strokeWidth: 8,
                backgroundColor: Colors.transparent,
                valueColor: const AlwaysStoppedAnimation(AppColors.focusPrimary),
              );
            },
          ),
          if (child != null) Center(child: child!),
        ],
      ),
    );
  }
}
