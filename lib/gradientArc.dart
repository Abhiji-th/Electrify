import 'package:flutter/material.dart';
import 'dart:math' as math;

class GradientSemiCircularProgress extends StatelessWidget {
  final double value;
  final double strokeWidth;
  final Color startColor;
  final Color endColor;

  GradientSemiCircularProgress({
    required this.value,
    this.strokeWidth = 4.0,
    this.startColor = Colors.blue,
    this.endColor = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GradientSemiCircularProgressPainter(
        value: value,
        strokeWidth: strokeWidth,
        startColor: startColor,
        endColor: endColor,
      ),
      size: Size.square(100.0), // Adjust the size as needed
    );
  }
}

class _GradientSemiCircularProgressPainter extends CustomPainter {
  final double value;
  final double strokeWidth;
  final Color startColor;
  final Color endColor;

  _GradientSemiCircularProgressPainter({
    required this.value,
    required this.strokeWidth,
    required this.startColor,
    required this.endColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height),
      radius: size.width / 2 - strokeWidth / 2,
    );

    final gradient = SweepGradient(
      startAngle: -math.pi / 2,
      endAngle: math.pi / 2,
      tileMode: TileMode.clamp,
      colors: [startColor, endColor],
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = gradient.createShader(rect);

    final startAngle = -math.pi / 2;
    final sweepAngle = math.pi * value;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
