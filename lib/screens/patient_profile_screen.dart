import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/hero_stat.dart';
import '../widgets/care_circle_tile.dart';
import '../utils/breakpoints.dart';
import '../data/dummy_data_service.dart';

class PatientProfileScreen extends StatelessWidget {
  const PatientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontal = Breakpoints.horizontalPadding(context);
    final _dataService = DummyDataService();
    final patient = _dataService.getCurrentPatient();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner_rounded),
            onPressed: () {},
          ),
          IconButton(icon: const Icon(Icons.edit_outlined), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(horizontal, 12, horizontal, 40),
        children: [
          Row(
            children: [
              Container(
                    height: 84,
                    width: 84,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF5DE0E6), Color(0xFF004AAD)],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        patient.avatarInitials,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                  .animate()
                  .scale(duration: 500.ms, curve: Curves.easeOutBack)
                  .shimmer(duration: 2000.ms, delay: 500.ms),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                          patient.name,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        )
                        .animate()
                        .fadeIn(duration: 400.ms, delay: 100.ms)
                        .slideX(begin: 0.1, end: 0),
                    Text(
                      'MRN · ${patient.mrn}',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                    ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 10,
                      children: patient.badges
                          .asMap()
                          .entries
                          .map(
                            (entry) =>
                                Chip(
                                      label: Text(entry.value),
                                      visualDensity: VisualDensity.compact,
                                    )
                                    .animate()
                                    .fadeIn(
                                      duration: 300.ms,
                                      delay: (entry.key * 100).ms,
                                    )
                                    .scale(
                                      delay: (entry.key * 100 + 50).ms,
                                      duration: 300.ms,
                                      curve: Curves.easeOutBack,
                                    ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.1, end: 0),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              HeroStat(label: 'Age', value: '${patient.age}')
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 400.ms)
                  .slideY(begin: 0.1, end: 0),
              HeroStat(label: 'Genes tracked', value: '${patient.genesTracked}')
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 500.ms)
                  .slideY(begin: 0.1, end: 0),
              HeroStat(
                    label: 'Protocols',
                    value: '${patient.activeProtocols} active',
                  )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 600.ms)
                  .slideY(begin: 0.1, end: 0),
              HeroStat(
                    label: 'Resp. score',
                    value: '${patient.respiratoryScore} / 100',
                  )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 700.ms)
                  .slideY(begin: 0.1, end: 0),
            ],
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
          const SizedBox(height: 24),
          Text(
            'Documents',
            style: Theme.of(context).textTheme.titleLarge,
          ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0),
          const SizedBox(height: 12),
          ...patient.documents.asMap().entries.map(
            (entry) =>
                ListTile(
                      tileColor: Colors.white.withValues(alpha: 0.02),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: BorderSide(
                          color: Colors.white.withValues(alpha: 0.04),
                        ),
                      ),
                      leading: const Icon(Icons.description_outlined),
                      title: Text(entry.value.title),
                      subtitle: Text(entry.value.subtitle),
                      trailing: const Icon(Icons.download_rounded),
                      onTap: () {},
                    )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: (600 + entry.key * 100).ms)
                    .slideX(begin: 0.1, end: 0),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout_rounded),
                label: const Text('Sign out'),
              )
              .animate()
              .fadeIn(duration: 400.ms, delay: 700.ms)
              .scale(
                delay: 700.ms,
                duration: 300.ms,
                curve: Curves.easeOutBack,
              ),
        ],
      ),
    );
  }
}
