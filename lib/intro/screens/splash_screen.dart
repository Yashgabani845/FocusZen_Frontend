import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:focusappfrontend/theme/services/theme_provider.dart';
import 'package:focusappfrontend/theme/app_colors.dart';
import 'package:focusappfrontend/focus_timer/ui/flame_widget.dart';
import 'package:focusappfrontend/intro/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen to theme to get primary color
    final primaryColor = Provider.of<ThemeProvider>(context).primaryColor;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            // Animated Flame Logo
            FlameWidget(
              glowColor: primaryColor,
              size: 110,
              animate: true,
            ),
            const SizedBox(height: 24),
            // App Name
            const Text(
              'FocusZen',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            // Tagline
            const Text(
              'Focus Better. Live Better.',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
            const Spacer(),
            // Loading Indicator
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
