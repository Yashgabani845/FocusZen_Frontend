// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:focusappfrontend/theme/app_colors.dart';
import 'package:focusappfrontend/theme/ui/blur_container.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final List<BoxShadow>? boxShadow;

  const GlassContainer({
    super.key,
    required this.child,
    this.blur = 15.0,
    this.opacity = 0.05,
    this.borderRadius,
    this.padding,
    this.width,
    this.height,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final defaultRadius = BorderRadius.circular(16);
    final borderR = borderRadius ?? defaultRadius;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderR,
        boxShadow: boxShadow,
      ),
      child: BlurContainer(
        blur: blur,
        borderRadius: borderR,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: borderR,
            border: Border.all(
              color: AppColors.borderOverlay,
              width: 1.0,
            ),
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(opacity + 0.05),
                Colors.white.withOpacity(opacity),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
