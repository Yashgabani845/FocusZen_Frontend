// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class FocusChart extends StatelessWidget {
  final List<double> data;
  
  const FocusChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: double.infinity,
      child: CustomPaint(
        painter: _ChartPainter(data),
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  final List<double> data;
  _ChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;
    
    final paint = Paint()
      ..color = AppColors.focusPrimary
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
      
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.focusPrimary.withOpacity(0.3),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    double maxData = 0;
    for (var val in data) {
      if (val > maxData) maxData = val;
    }
    final maxVal = maxData > 0 ? maxData : 1;
    final dx = data.length > 1 ? size.width / (data.length - 1) : size.width;
    
    final path = Path();
    path.moveTo(0, size.height - (data[0] / maxVal) * size.height);
    
    for (int i = 0; i < data.length - 1; i++) {
      final p1 = Offset(i * dx, size.height - (data[i] / maxVal) * size.height);
      final p2 = Offset((i + 1) * dx, size.height - (data[i + 1] / maxVal) * size.height);
      
      final controlPointX = p1.dx + (p2.dx - p1.dx) / 2;
      path.cubicTo(
        controlPointX, p1.dy,
        controlPointX, p2.dy,
        p2.dx, p2.dy,
      );
    }
    
    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);
    
    final dotPaint = Paint()..color = Colors.white;
    for (int i = 0; i < data.length; i++) {
      canvas.drawCircle(Offset(i * dx, size.height - (data[i] / maxVal) * size.height), 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
