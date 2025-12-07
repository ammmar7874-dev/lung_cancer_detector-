import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProcessTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool complete;

  const ProcessTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.complete = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: complete
              ? scheme.primary.withValues(alpha: 0.3)
              : Colors.white.withValues(alpha: 0.04),
        ),
        color: complete
            ? scheme.primary.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.02),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: complete
                  ? scheme.primary.withValues(alpha: 0.2)
                  : Colors.white.withValues(alpha: 0.05),
            ),
            child: Icon(
              icon,
              color: complete ? scheme.primary : Colors.white,
            ),
          )
              .animate(target: complete ? 1 : 0)
              .scale(duration: 400.ms, curve: Curves.easeOutBack),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
          Icon(
            complete ? Icons.check_circle : Icons.timelapse,
            color: complete ? scheme.primary : Colors.white54,
          )
              .animate(target: complete ? 1 : 0)
              .scale(duration: 400.ms, curve: Curves.easeOutBack),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideX(begin: 0.1, end: 0);
  }
}

