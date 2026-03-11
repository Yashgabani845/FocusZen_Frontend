// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../widgets/buttons/focus_primary_button.dart';
import '../widgets/progress/circular_focus_progress.dart';
import '../widgets/flame/flame_widget.dart';

class FocusTimerScreen extends StatelessWidget {
  const FocusTimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppGradients.backgroundGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),
                CircularFocusProgress(
                  progress: 0.65, // Active progress demo
                  size: 320,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FlameWidget(
                        glowColor: AppColors.focusPrimary,
                        size: 140,
                        animate: true,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '18:45',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'remaining',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textSecondary.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Spacer(flex: 2),
                
                Row(
                  children: [
                    Expanded(
                      child: FocusPrimaryButton(
                        text: 'PAUSE',
                        isNeutral: true,
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: FocusPrimaryButton(
                        text: 'END',
                        isNeutral: false,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
