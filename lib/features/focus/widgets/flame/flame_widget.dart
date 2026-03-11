// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';

class FlameWidget extends StatefulWidget {
  final Color glowColor;
  final double size;
  final bool animate;

  const FlameWidget({
    super.key,
    required this.glowColor,
    this.size = 100,
    this.animate = true,
  });

  @override
  State<FlameWidget> createState() => _FlameWidgetState();
}

class _FlameWidgetState extends State<FlameWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    
    if (widget.animate) {
      _controller.repeat(reverse: true);
    }
  }
  
  @override
  void didUpdateWidget(FlameWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.animate && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: widget.animate ? _scaleAnimation.value : 1.0,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: widget.glowColor.withOpacity(0.4 * (widget.animate ? _scaleAnimation.value : 1.0)),
                  blurRadius: widget.size * 0.4,
                  spreadRadius: widget.size * 0.1,
                )
              ],
            ),
            child: Icon(
              Icons.local_fire_department,
              color: widget.glowColor,
              size: widget.size,
            ),
          ),
        );
      },
    );
  }
}
