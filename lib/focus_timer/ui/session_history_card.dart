import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:focusappfrontend/theme/app_colors.dart';
import 'package:focusappfrontend/theme/ui/glass_container.dart';

class SessionHistoryCard extends StatefulWidget {
  final int duration;
  final int interruptions;
  final String startTime;

  const SessionHistoryCard({
    super.key,
    required this.duration,
    required this.interruptions,
    required this.startTime,
  });

  @override
  State<SessionHistoryCard> createState() => _SessionHistoryCardState();
}

class _SessionHistoryCardState extends State<SessionHistoryCard> {
  bool _isHovering = false;

  String _formatDuration(int totalSeconds) {
    if (totalSeconds < 60) return '${totalSeconds}s';
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes}m ${seconds}s';
  }

  String _formatDate(String isoString) {
    try {
      final date = DateTime.parse(isoString).toLocal();
      return DateFormat('MMM d, yyyy • h:mm a').format(date);
    } catch (e) {
      return 'Unknown Date';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isHovering = true),
        onTapUp: (_) => setState(() => _isHovering = false),
        onTapCancel: () => setState(() => _isHovering = false),
        child: AnimatedScale(
          scale: _isHovering ? 0.98 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: GlassContainer(
            padding: const EdgeInsets.all(16),
            boxShadow: _isHovering 
                ? [
                    BoxShadow(
                      color: AppColors.focusPrimary.withOpacity(0.2),
                      blurRadius: 15,
                      spreadRadius: 2,
                    )
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _isHovering ? AppColors.focusPrimary.withOpacity(0.1) : AppColors.surfaceDark,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.history_toggle_off,
                    color: _isHovering ? AppColors.focusPrimary : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatDate(widget.startTime),
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.av_timer, size: 12, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Text(
                            _formatDuration(widget.duration),
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Icon(Icons.do_not_disturb_on, size: 12, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.interruptions} int.',
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: _isHovering ? AppColors.focusPrimary : Colors.transparent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
