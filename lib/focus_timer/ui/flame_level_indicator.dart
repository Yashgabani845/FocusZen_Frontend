// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:focusappfrontend/theme/app_colors.dart';
import 'flame_widget.dart';

class FlameLevelIndicator extends StatelessWidget {
  final int currentLevel;

  const FlameLevelIndicator({
    super.key,
    required this.currentLevel,
  });

  @override
  Widget build(BuildContext context) {
    final stages = [
      {'label': 'Spark', 'color': AppColors.flameSpark},
      {'label': 'Flame', 'color': AppColors.flameClassic},
      {'label': 'Inferno', 'color': AppColors.flameInferno},
      {'label': 'Legendary', 'color': AppColors.flameCosmic},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(stages.length, (index) {
        final isActive = index <= currentLevel;
        final isCurrent = index == currentLevel;
        final stageColor = stages[index]['color'] as Color;

        return Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    FlameWidget(
                      glowColor: isActive ? stageColor : AppColors.textSecondary.withOpacity(0.3),
                      size: isCurrent ? 50 : 35,
                      animate: isCurrent,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      stages[index]['label'] as String,
                      style: TextStyle(
                        color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              if (index < stages.length - 1)
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: isActive ? stageColor.withOpacity(0.5) : AppColors.textSecondary.withOpacity(0.3),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
