import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_glow.dart';
import '../widgets/navigation/bottom_navbar.dart';
import '../widgets/stats/stat_card.dart';
import '../widgets/buttons/focus_primary_button.dart';
import '../widgets/progress/circular_focus_progress.dart';
import '../widgets/flame/flame_widget.dart';
import 'analytics_screen.dart';
import 'flame_progress_screen.dart';
import 'flame_customization_screen.dart';
import 'focus_timer_screen.dart';

class FocusHomeScreen extends StatefulWidget {
  const FocusHomeScreen({super.key});

  @override
  State<FocusHomeScreen> createState() => _FocusHomeScreenState();
}

class _FocusHomeScreenState extends State<FocusHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const _HomeContent(),
    const AnalyticsScreen(),
    const FlameProgressScreen(),
    const FlameCustomizationScreen(), // Reusing Customization screen as Profile mapping for now as per design
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _screens[_currentIndex],
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - 48, // Adjust for padding and safe area
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Top Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'FocusZen',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            gradient: AppGradients.focusButton,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: AppGlow.ambientGlow(AppColors.focusPrimary),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '6K ',
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Icon(Icons.local_fire_department, size: 16, color: Colors.white),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    const Spacer(),
                    
                    // Center Section
                    const Center(
                      child: CircularFocusProgress(
                        progress: 0.1,
                        size: 280,
                        child: FlameWidget(
                          glowColor: AppColors.focusPrimary,
                          size: 110,
                          animate: true,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    const Center(
                      child: Text(
                        'Focus Timer',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    
                    const Spacer(),
                    
                    FocusPrimaryButton(
                      text: 'Start Focus',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const FocusTimerScreen()),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Stat Cards
                    const Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: 'Streak',
                            value: '14\ndays',
                            icon: Icons.calendar_month,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: 'Total Hours',
                            value: '285\nhours',
                            icon: Icons.access_time,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: 'Energy',
                            value: '75%',
                            icon: Icons.bolt,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
