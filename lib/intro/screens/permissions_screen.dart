import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:focusappfrontend/theme/services/theme_provider.dart';
import 'package:focusappfrontend/theme/app_colors.dart';
import 'package:focusappfrontend/intro/screens/auth_screen.dart';
import 'package:focusappfrontend/intro/ui/permission_card.dart';
import 'package:focusappfrontend/intro/ui/animated_focus_pet.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  bool _usageGranted = false;
  bool _notificationsGranted = false;

  void _continue() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AuthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Provider.of<ThemeProvider>(context).primaryColor;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              // Top Icon/Illustration
              // Animated Pet Actor (Guide)
              Center(
                child: SizedBox(
                  height: 180,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor.withOpacity(0.05),
                        ),
                      ),
                      const AnimatedFocusPet(pageIndex: 2), // Index 2 expression
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Pet Dialogue
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: primaryColor.withOpacity(0.2)),
                ),
                child: const Text(
                  "I need a few permissions to protect your time. They stay 100% on your device!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 48),
              
              const Text(
                'Permissions Required',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'FocusZen needs a few permissions to help you block distractions and securely track your focus time locally.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 48),

              // Permissions List
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    PermissionCard(
                      icon: Icons.app_blocking_outlined,
                      title: 'Usage Access',
                      description: 'Required to track and block distracting apps.',
                      isGranted: _usageGranted,
                      primaryColor: primaryColor,
                      onToggle: () {
                        setState(() => _usageGranted = true);
                        // Implement actual permission request logic here later
                      },
                    ),
                    const SizedBox(height: 16),
                    PermissionCard(
                      icon: Icons.notifications_active_outlined,
                      title: 'Notifications',
                      description: 'Allows focus alerts and streak reminders.',
                      isGranted: _notificationsGranted,
                      primaryColor: primaryColor,
                      onToggle: () {
                        setState(() => _notificationsGranted = true);
                        // Implement actual permission request logic here later
                      },
                    ),
                  ],
                ),
              ),

              // Bottom Continue Button
              ElevatedButton(
                onPressed: (_usageGranted && _notificationsGranted) ? _continue : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  disabledBackgroundColor: AppColors.surfaceDark,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Small text allowing to skip for dev/demo purposes until actual hardware permissions code is added
              TextButton(
                onPressed: _continue,
                child: const Text(
                  'Skip for now (Demo)',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
