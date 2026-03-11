// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../widgets/containers/glass_container.dart';
import '../widgets/flame/flame_widget.dart';

class FlameCustomizationScreen extends StatefulWidget {
  const FlameCustomizationScreen({super.key});

  @override
  State<FlameCustomizationScreen> createState() => _FlameCustomizationScreenState();
}

class _FlameCustomizationScreenState extends State<FlameCustomizationScreen> {
  int _selectedIndex = 1; // Default to Blue Focus

  final List<Map<String, dynamic>> _flameStyles = [
    {
      'name': 'Classic Fire',
      'color': AppColors.flameClassic,
      'isLocked': false,
      'subtitle': 'Unlock',
    },
    {
      'name': 'Blue Focus',
      'color': AppColors.focusPrimary,
      'isLocked': false,
      'subtitle': 'Required streak',
    },
    {
      'name': 'Cosmic',
      'color': AppColors.flameCosmic,
      'isLocked': true,
      'subtitle': 'Required streak',
    },
    {
      'name': 'Crystal',
      'color': AppColors.flameCrystal,
      'isLocked': true,
      'subtitle': 'Unlock',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final selectedFlame = _flameStyles[_selectedIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Flame Customization'),
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
          child: Column(
            children: [
              const SizedBox(height: 24),
              // Large preview
              FlameWidget(
                glowColor: selectedFlame['color'],
                size: 200,
                animate: true,
              ),
              
              const SizedBox(height: 48),
              
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: _flameStyles.length,
                  itemBuilder: (context, index) {
                    final flame = _flameStyles[index];
                    final isSelected = _selectedIndex == index;
                    final isLocked = flame['isLocked'];
                    
                    return GestureDetector(
                      onTap: () {
                        if (!isLocked) {
                          setState(() {
                            _selectedIndex = index;
                          });
                        }
                      },
                      child: GlassContainer(
                        padding: const EdgeInsets.all(16),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: flame['color'].withOpacity(0.3),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                )
                              ]
                            : null,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (isLocked)
                                  const Icon(Icons.lock, color: AppColors.textSecondary, size: 14)
                                else
                                  const SizedBox(height: 14),
                              ],
                            ),
                            Icon(
                              Icons.local_fire_department,
                              color: flame['color'],
                              size: 48,
                            ),
                            const Spacer(),
                            Text(
                              flame['name'],
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              isLocked ? flame['subtitle'] : 'Unlocked',
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
