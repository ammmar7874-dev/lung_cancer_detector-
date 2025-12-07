import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/glass_card.dart';
import '../widgets/appointment_card.dart';
import '../widgets/care_circle_tile.dart';
import '../utils/breakpoints.dart';
import '../data/dummy_data_service.dart';

class CarePlanScreen extends StatelessWidget {
  const CarePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontal = Breakpoints.horizontalPadding(context);
    final _dataService = DummyDataService();
    final appointments = _dataService.getUpcomingAppointments();
    final tasks = _dataService.getCareTasks();
    final patient = _dataService.getCurrentPatient();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Care continuum'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.chat_bubble_outline_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(horizontal, 8, horizontal, 40),
        children: [
          Text(
            'Upcoming experiences',
            style: Theme.of(context).textTheme.titleLarge,
          ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0),
          const SizedBox(height: 16),
          ...appointments.map(
            (appt) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: AppointmentCard(appointment: appt),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Daily rituals',
            style: Theme.of(context).textTheme.titleLarge,
          ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0),
          const SizedBox(height: 12),
          ...tasks.asMap().entries.map(
            (entry) =>
                ListTile(
                      tileColor: Colors.white.withValues(alpha: 0.02),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: BorderSide(
                          color: Colors.white.withValues(alpha: 0.05),
                        ),
                      ),
                      leading:
                          Icon(
                                entry.value.completed
                                    ? Icons.verified_rounded
                                    : Icons.radio_button_unchecked_rounded,
                                color: entry.value.completed
                                    ? Colors.teal
                                    : Colors.white54,
                              )
                              .animate(target: entry.value.completed ? 1 : 0)
                              .scale(
                                duration: 400.ms,
                                curve: Curves.easeOutBack,
                              ),
                      title: Text(entry.value.title),
                      subtitle: Text(entry.value.adherenceText),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () {},
                    )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: (entry.key * 100).ms)
                    .slideX(begin: 0.1, end: 0),
          ),
          const SizedBox(height: 24),
          GlassCard(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                                'Need human support?',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              )
                              .animate()
                              .fadeIn(duration: 400.ms)
                              .slideX(begin: -0.1, end: 0),
                          const SizedBox(height: 6),
                          Text(
                            'Certified coaches, pulmonologists & nutritionists reply under 5 min.',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: Colors.white70),
                          ).animate().fadeIn(duration: 400.ms, delay: 100.ms),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    FilledButton(
                          onPressed: () {},
                          child: const Text('Open lounge'),
                        )
                        .animate()
                        .fadeIn(duration: 400.ms, delay: 200.ms)
                        .scale(
                          delay: 200.ms,
                          duration: 300.ms,
                          curve: Curves.easeOutBack,
                        ),
                  ],
                ),
              )
              .animate()
              .fadeIn(duration: 500.ms, delay: 300.ms)
              .scale(
                delay: 300.ms,
                duration: 400.ms,
                curve: Curves.easeOutBack,
              ),
          const SizedBox(height: 24),
          Text(
            'Care circle',
            style: Theme.of(context).textTheme.titleLarge,
          ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              final isStacked = constraints.maxWidth < 640;
              final tiles = patient.careCircle
                  .map(
                    (provider) => CareCircleTile(
                      title: provider.name,
                      subtitle: provider.role,
                      avatarInitials: provider.avatarInitials,
                      expanded: !isStacked,
                    ),
                  )
                  .toList();

              if (isStacked) {
                return Column(
                  children: [
                    ...tiles.map(
                      (tile) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: SizedBox(width: double.infinity, child: tile),
                      ),
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  tiles.first,
                  const SizedBox(width: 12),
                  if (tiles.length > 1) tiles.last,
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
