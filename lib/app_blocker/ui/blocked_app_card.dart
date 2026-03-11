import 'package:flutter/material.dart';
import 'package:focusappfrontend/theme/app_colors.dart';
import 'package:focusappfrontend/theme/ui/glass_container.dart';

class BlockedAppCard extends StatelessWidget {
  final String id;
  final String name;
  final String timeString;
  final Widget icon;
  final bool isBlocked;
  final ValueChanged<bool> onToggle;

  const BlockedAppCard({
    super.key,
    required this.id,
    required this.name,
    required this.timeString,
    required this.icon,
    required this.isBlocked,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GlassContainer(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Usage today: \$timeString',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: isBlocked,
              onChanged: onToggle,
              activeColor: AppColors.focusPrimary,
              activeTrackColor: AppColors.focusPrimary.withOpacity(0.5),
              inactiveThumbColor: AppColors.textSecondary,
              inactiveTrackColor: AppColors.surfaceDark,
            ),
          ],
        ),
      ),
    );
  }
}
