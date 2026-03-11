import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:focusappfrontend/theme/app_colors.dart';
import 'package:focusappfrontend/theme/app_gradients.dart';
import 'package:focusappfrontend/theme/services/theme_provider.dart';
import 'package:focusappfrontend/intro/ui/animated_focus_pet.dart';
import 'package:focusappfrontend/focus_timer/ui/flame_widget.dart';
import 'package:focusappfrontend/focus_timer/ui/focus_primary_button.dart';

class FocusSuccessScreen extends StatefulWidget {
  final int durationSeconds;
  final int interruptions;

  const FocusSuccessScreen({
    super.key,
    required this.durationSeconds,
    required this.interruptions,
  });

  @override
  State<FocusSuccessScreen> createState() => _FocusSuccessScreenState();
}

class _FocusSuccessScreenState extends State<FocusSuccessScreen> with SingleTickerProviderStateMixin {
  late AnimationController _flareController;
  late Animation<double> _flareAnimation;

  @override
  void initState() {
    super.initState();
    _flareController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _flareAnimation = Tween<double>(begin: 1.0, end: 1.4).animate(
      CurvedAnimation(parent: _flareController, curve: Curves.easeInOutExpo),
    );
  }

  @override
  void dispose() {
    _flareController.dispose();
    super.dispose();
  }

  String _formatDuration(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    if (minutes > 0) {
      return '$minutes min $seconds sec';
    }
    return '$seconds sec';
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Provider.of<ThemeProvider>(context).primaryColor;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppGradients.backgroundGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Column(
              children: [
                const Spacer(),
                
                // Celebratory Header
                const Text(
                  'FOCUS COMPLETE!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary,
                    letterSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'You grew your flame today',
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryColor.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const Spacer(),

                // Central Visual: Bursting Flame & Happy Pet
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Flare Effect
                    ScaleTransition(
                      scale: _flareAnimation,
                      child: Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withOpacity(0.15),
                              blurRadius: 100,
                              spreadRadius: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Large Celebratory Flame
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FlameWidget(
                          size: 160,
                          glowColor: primaryColor,
                          animate: true,
                        ),
                        const SizedBox(height: 16),
                        // Successful Pet
                        const SizedBox(
                          height: 120,
                          child: AnimatedFocusPet(pageIndex: 0), // Expression 0 is happy/neutral
                        ),
                      ],
                    ),
                  ],
                ),

                const Spacer(),

                // Summary Stats Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceDark,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: primaryColor.withOpacity(0.2)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem('Duration', _formatDuration(widget.durationSeconds), Icons.timer_outlined, primaryColor),
                      Container(width: 1, height: 40, color: Colors.white10),
                      _buildStatItem('Interruptions', widget.interruptions.toString(), Icons.pause_circle_outline, primaryColor),
                    ],
                  ),
                ),

                const Spacer(),

                // Back Home Button
                FocusPrimaryButton(
                  text: 'DONE',
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
