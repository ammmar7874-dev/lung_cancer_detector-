import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CareCircleTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String avatarInitials;
  final bool expanded;

  const CareCircleTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.avatarInitials,
    this.expanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
        color: Colors.white.withValues(alpha: 0.02),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
            child: Text(
              avatarInitials,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
              .animate()
              .scale(duration: 400.ms, curve: Curves.easeOutBack),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                )
                    .animate()
                    .fadeIn(duration: 300.ms)
                    .slideX(begin: 0.1, end: 0),
                Text(
                  subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white70),
                )
                    .animate()
                    .fadeIn(duration: 300.ms, delay: 100.ms)
                    .slideX(begin: 0.1, end: 0),
              ],
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms)
        .scale(delay: 50.ms, duration: 300.ms, curve: Curves.easeOutBack);

    if (expanded) {
      return Expanded(child: content);
    }
    return content;
  }
}

