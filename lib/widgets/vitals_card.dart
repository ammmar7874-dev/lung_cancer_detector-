import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'sparkline_painter.dart';

class VitalsCard extends StatelessWidget {
  final String label;
  final String value;
  final String detail;
  final List<double> sparkline;

  const VitalsCard({
    super.key,
    required this.label,
    required this.value,
    required this.detail,
    required this.sparkline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
        color: Colors.white.withValues(alpha: 0.02),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: Colors.white70),
          )
              .animate()
              .fadeIn(duration: 300.ms)
              .slideY(begin: -0.1, end: 0),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge,
          )
              .animate()
              .fadeIn(duration: 400.ms, delay: 100.ms)
              .scale(delay: 100.ms, duration: 300.ms, curve: Curves.easeOutBack),
          Text(
            detail,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.white60),
          )
              .animate()
              .fadeIn(duration: 300.ms, delay: 200.ms),
          const Spacer(),
          SizedBox(
            height: 32,
            child: CustomPaint(
              painter: SparklinePainter(points: sparkline),
            ),
          )
              .animate()
              .fadeIn(duration: 500.ms, delay: 300.ms)
              .slideX(begin: -0.2, end: 0),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms)
        .scale(delay: 50.ms, duration: 300.ms, curve: Curves.easeOutBack);
  }
}

