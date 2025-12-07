import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProgramCard extends StatelessWidget {
  final String title;
  final String description;
  final double accuracy;
  final List<Color> gradient;
  final IconData icon;

  const ProgramCard({
    super.key,
    required this.title,
    required this.description,
    required this.accuracy,
    required this.gradient,
    this.icon = Icons.medical_services_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: gradient.last.withValues(alpha: 0.4),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.white.withValues(alpha: 0.9),
              size: 32,
            )
                .animate()
                .scale(duration: 600.ms, delay: 100.ms, curve: Curves.easeOutBack),
            const Spacer(),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            )
                .animate()
                .fadeIn(duration: 400.ms, delay: 200.ms)
                .slideY(begin: 0.1, end: 0),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white70),
            )
                .animate()
                .fadeIn(duration: 400.ms, delay: 300.ms)
                .slideY(begin: 0.1, end: 0),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Accuracy ${accuracy.toStringAsFixed(1)}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                )
                    .animate()
                    .scale(duration: 400.ms, delay: 400.ms, curve: Curves.easeOutBack),
                const Spacer(),
                const Icon(Icons.arrow_forward_rounded, color: Colors.white)
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 500.ms),
              ],
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .scale(delay: 100.ms, duration: 500.ms, curve: Curves.easeOutBack);
  }
}

