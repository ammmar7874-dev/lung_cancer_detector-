import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/appointment.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const AppointmentCard({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: LinearGradient(
          colors: appointment.accentColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: appointment.accentColors.last.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appointment.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
          )
              .animate()
              .fadeIn(duration: 400.ms)
              .slideY(begin: -0.1, end: 0),
          const SizedBox(height: 6),
          Text(
            appointment.clinician,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white70),
          )
              .animate()
              .fadeIn(duration: 400.ms, delay: 100.ms)
              .slideY(begin: -0.1, end: 0),
          const SizedBox(height: 18),
          Row(
            children: [
              const Icon(Icons.schedule_rounded, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                appointment.formattedDate,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          )
              .animate()
              .fadeIn(duration: 400.ms, delay: 200.ms),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  appointment.location,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
              .animate()
              .fadeIn(duration: 400.ms, delay: 300.ms),
          const SizedBox(height: 18),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: appointment.accentColors.first,
              ),
              child: const Text('Open briefing'),
            ),
          )
              .animate()
              .fadeIn(duration: 400.ms, delay: 400.ms)
              .scale(delay: 400.ms, duration: 300.ms, curve: Curves.easeOutBack),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 500.ms)
        .scale(delay: 100.ms, duration: 400.ms, curve: Curves.easeOutBack);
  }
}

