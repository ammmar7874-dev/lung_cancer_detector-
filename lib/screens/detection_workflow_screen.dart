import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/glass_card.dart';
import '../widgets/process_tile.dart';
import '../widgets/vitals_card.dart';
import '../utils/breakpoints.dart';
import '../data/dummy_data_service.dart';

class DetectionWorkflowScreen extends StatefulWidget {
  const DetectionWorkflowScreen({super.key});

  @override
  State<DetectionWorkflowScreen> createState() =>
      _DetectionWorkflowScreenState();
}

class _DetectionWorkflowScreenState extends State<DetectionWorkflowScreen> {
  int _stage = 0;
  final _dataService = DummyDataService();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final horizontal = Breakpoints.horizontalPadding(context);
    final latestScan = _dataService.getLatestScanResult();
    final biomarkers = latestScan.biomarkers;

    final stages = [
      {
        'title': 'Upload CT / PET',
        'subtitle': 'DICOM validated • contrast optimized',
        'icon': Icons.cloud_upload_outlined,
      },
      {
        'title': 'AI volumetric scan',
        'subtitle': '7.8M voxel pairs compared',
        'icon': Icons.hub_outlined,
      },
      {
        'title': 'Clinician review',
        'subtitle': 'Augmented overlay pushed to XR room',
        'icon': Icons.health_and_safety_outlined,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detection workflow'),
        actions: [TextButton(onPressed: () {}, child: const Text('History'))],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(horizontal, 8, horizontal, 32),
        children: [
          GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: scheme.primary.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Icon(
                                Icons.biotech_rounded,
                                color: scheme.primary,
                              ),
                            )
                            .animate()
                            .scale(duration: 400.ms, curve: Curves.easeOutBack)
                            .shimmer(duration: 2000.ms, delay: 400.ms),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                    'LungGuard detection lab',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  )
                                  .animate()
                                  .fadeIn(duration: 400.ms, delay: 100.ms)
                                  .slideX(begin: 0.1, end: 0),
                              Text(
                                'confidence index ${latestScan.confidence.toStringAsFixed(1)}% • v3.1 quantum core',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: Colors.white70),
                              ).animate().fadeIn(
                                duration: 400.ms,
                                delay: 200.ms,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.settings_backup_restore_rounded,
                          ),
                          onPressed: () => setState(
                            () => _stage = _stage == 2 ? 0 : _stage + 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child:
                              FilledButton.icon(
                                    style: FilledButton.styleFrom(
                                      minimumSize: const Size.fromHeight(52),
                                      backgroundColor: scheme.primary,
                                      foregroundColor: Colors.black,
                                    ),
                                    onPressed: () {
                                      setState(() => _stage = 0);
                                    },
                                    icon: const Icon(
                                      Icons.cloud_upload_rounded,
                                    ),
                                    label: const Text('Upload scan'),
                                  )
                                  .animate()
                                  .fadeIn(duration: 400.ms, delay: 300.ms)
                                  .scale(
                                    delay: 300.ms,
                                    duration: 300.ms,
                                    curve: Curves.easeOutBack,
                                  ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child:
                              OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                      minimumSize: const Size.fromHeight(52),
                                    ),
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.camera_indoor_outlined,
                                    ),
                                    label: const Text('Live CT link'),
                                  )
                                  .animate()
                                  .fadeIn(duration: 400.ms, delay: 400.ms)
                                  .scale(
                                    delay: 400.ms,
                                    duration: 300.ms,
                                    curve: Curves.easeOutBack,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
              .animate()
              .fadeIn(duration: 500.ms)
              .scale(
                delay: 100.ms,
                duration: 400.ms,
                curve: Curves.easeOutBack,
              ),
          const SizedBox(height: 24),
          ...stages.asMap().entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ProcessTile(
                title: entry.value['title'] as String,
                subtitle: entry.value['subtitle'] as String,
                icon: entry.value['icon'] as IconData,
                complete: _stage > entry.key,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Live biomarkers',
            style: Theme.of(context).textTheme.titleLarge,
          ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              final cards = [
                VitalsCard(
                  label: 'Breath VOC delta',
                  value: '${biomarkers.breathVOC.toStringAsFixed(1)}%',
                  detail: 'vs last week',
                  sparkline: biomarkers.vocHistory,
                ),
                VitalsCard(
                  label: 'Resp. rhythm',
                  value: '${biomarkers.respiratoryRate.toStringAsFixed(0)} bpm',
                  detail: 'steady variance',
                  sparkline: biomarkers.respiratoryHistory,
                ),
                VitalsCard(
                  label: 'Blood oxygen',
                  value: '${biomarkers.bloodOxygen.toStringAsFixed(0)}%',
                  detail: 'wearable mesh',
                  sparkline: biomarkers.oxygenHistory,
                ),
                VitalsCard(
                  label: 'Exhaled temp',
                  value: '${biomarkers.exhaledTemp.toStringAsFixed(1)}°C',
                  detail: 'optimal range',
                  sparkline: biomarkers.tempHistory,
                ),
              ];

              final computed = Breakpoints.gridColumns(context, mobile: 2);
              final columns = computed > 3 ? 3 : computed;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cards.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: constraints.maxWidth > 800 ? 1.4 : 1.2,
                ),
                itemBuilder: (context, index) => cards[index],
              );
            },
          ),
        ],
      ),
    );
  }
}
