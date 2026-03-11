import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../widgets/containers/glass_container.dart';
import '../widgets/charts/focus_chart.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Analytics'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textSecondary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppGradients.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GlassContainer(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Today's focus",
                              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '3h 15m',
                              style: TextStyle(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GlassContainer(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Current streak",
                                  style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '# ',
                                  style: TextStyle(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Icon(Icons.local_fire_department, color: AppColors.focusPrimary, size: 28),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                const Text(
                  'Daily sessions',
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                
                GlassContainer(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const FocusChart(data: [10.0, 25.0, 15.0, 40.0, 20.0, 30.0, 15.0]),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Sun', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                          Text('Mon', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                          Text('Tue', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                          Text('Wed', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                          Text('Thu', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                          Text('Fri', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                          Text('Sat', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                const Text(
                  'Weekly trends',
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                
                GlassContainer(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const FocusChart(data: [40.0, 60.0, 45.0, 80.0, 50.0, 90.0, 110.0]),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Sun', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                          Text('Mon', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                          Text('Tue', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                          Text('Wed', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                          Text('Thu', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                          Text('Fri', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                          Text('Sat', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                Row(
                  children: [
                    Expanded(
                      child: GlassContainer(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('3h', style: TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text('Total Hours Focused', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GlassContainer(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('10', style: TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text('Longest Streak', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GlassContainer(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('32', style: TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text('Sessions Completed', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
