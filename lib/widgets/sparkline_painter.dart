import 'package:flutter/material.dart';

class SparklinePainter extends CustomPainter {
  final List<double> points;

  SparklinePainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF5DE0E6), Color(0xFF36C8FF)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    for (var i = 0; i < points.length; i++) {
      final x = (i / (points.length - 1)) * size.width;
      final y = size.height - (points[i] * size.height);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant SparklinePainter oldDelegate) =>
      oldDelegate.points != points;
}

