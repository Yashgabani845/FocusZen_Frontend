import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:focusappfrontend/theme/services/theme_provider.dart';
import 'package:focusappfrontend/theme/app_colors.dart';

class AnimatedFocusPet extends StatefulWidget {
  final int pageIndex;
  
  const AnimatedFocusPet({super.key, required this.pageIndex});

  @override
  State<AnimatedFocusPet> createState() => _AnimatedFocusPetState();
}

class _AnimatedFocusPetState extends State<AnimatedFocusPet> with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _blinkController;
  late AnimationController _bounceController;

  @override
  void initState() {
    super.initState();
    
    // Floating Animation (Continuous breathing/hovering motion)
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    // Blinking Animation (Randomly fires)
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _startBlinkTimer();

    // Interaction Bounce (Fires on Tap)
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _startBlinkTimer() {
    Future.delayed(Duration(milliseconds: 2000 + math.Random().nextInt(4000)), () {
      if (mounted) {
        _blinkController.forward().then((_) {
          _blinkController.reverse();
          _startBlinkTimer();
        });
      }
    });
  }

  void _pokePet() {
    if (!_bounceController.isAnimating) {
      _bounceController.forward().then((_) => _bounceController.reverse());
    }
  }

  @override
  void dispose() {
    _floatController.dispose();
    _blinkController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Provider.of<ThemeProvider>(context).primaryColor;

    return GestureDetector(
      onTap: _pokePet,
      child: AnimatedBuilder(
        animation: Listenable.merge([_floatController, _blinkController, _bounceController]),
        builder: (context, child) {
          // Floating Y offset
          final floatOffset = math.sin(_floatController.value * math.pi) * 15;
          // Squeeze and stretch on poke
          final squeezeX = 1.0 - (_bounceController.value * 0.15);
          final squeezeY = 1.0 + (_bounceController.value * 0.15);
          // Scale based on page index (morphs slightly per stage)
          final stageScale = 1.0 + (widget.pageIndex * 0.05);

          return Transform.translate(
            offset: Offset(0, -floatOffset),
            child: Transform.scale(
              scaleX: squeezeX * stageScale,
              scaleY: squeezeY * stageScale,
              alignment: FractionalOffset.bottomCenter,
              child: _buildPetBody(primaryColor),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPetBody(Color themeColor) {
    // Modify pet's expression based on page context
    bool isExcited = widget.pageIndex == 2; // e.g. "You're ready!" page
    bool isThinking = widget.pageIndex == 1; // e.g. "We block things" page

    final eyeScaleY = 1.0 - _blinkController.value; // Closes eyes fully on blink

    return Container(
      width: 140,
      height: 150,
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(70),
          topRight: const Radius.circular(70),
          bottomLeft: Radius.circular(isThinking ? 40 : 60),
          bottomRight: Radius.circular(isThinking ? 40 : 60),
        ),
        boxShadow: [
          BoxShadow(
            color: themeColor.withOpacity(0.3),
            blurRadius: 40,
            spreadRadius: 10,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 20), // Simulated grounded drop shadow
          )
        ],
        border: Border.all(
          color: themeColor.withOpacity(0.5),
          width: 3,
        ),
      ),
      child: Stack(
        children: [
          // Antenna (Glowing)
          Positioned(
            top: -20,
            left: 65,
            child: Container(
              width: 10,
              height: 30,
              decoration: BoxDecoration(
                color: themeColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(color: themeColor, blurRadius: 10, spreadRadius: 2)
                ],
              ),
            ),
          ),
          
          // Face Details
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Left Eye
                Transform.scale(
                  scaleY: eyeScaleY,
                  child: _buildEye(themeColor, isExcited),
                ),
                const SizedBox(width: 24),
                // Right Eye
                Transform.scale(
                  scaleY: eyeScaleY,
                  child: _buildEye(themeColor, isExcited),
                ),
              ],
            ),
          ),

          // Mouth / Indicator
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: isExcited ? 30 : 20,
                height: isExcited ? 20 : 8,
                decoration: BoxDecoration(
                  color: isExcited ? themeColor : AppColors.textSecondary,
                  borderRadius: isExcited 
                    ? const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                    : BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEye(Color color, bool isExcited) {
    return Container(
      width: 24,
      height: isExcited ? 30 : 24,
      decoration: BoxDecoration(
        color: color,
        borderRadius: isExcited ? BorderRadius.circular(15) : BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.8),
            blurRadius: 12,
            spreadRadius: 2,
          )
        ],
      ),
      child: Stack(
        children: [
          // Eye Glint
          Positioned(
            top: 4,
            right: 4,
            child: Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          )
        ],
      ),
    );
  }
}
