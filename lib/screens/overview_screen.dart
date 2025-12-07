import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/animated_background.dart';
import '../widgets/hero_stat.dart';
import '../widgets/program_card.dart';
import '../widgets/insight_card.dart';
import '../utils/breakpoints.dart';
import '../data/dummy_data_service.dart';
import '../theme/app_theme.dart';
import 'detection_workflow_screen.dart';
import 'insights_history_screen.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen>
    with TickerProviderStateMixin {
  late final AnimationController _haloController;
  late final PageController _programController;
  final _dataService = DummyDataService();

  @override
  void initState() {
    super.initState();
    _haloController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
    _programController = PageController(viewportFraction: 0.82);
  }

  @override
  void dispose() {
    _haloController.dispose();
    _programController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final patient = _dataService.getCurrentPatient();
    final latestScan = _dataService.getLatestScanResult();
    final programs = _dataService.getProgramCards();
    final insights = _dataService.getRiskInsights();
    final timelineEvents = _dataService.getTimelineEvents();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('LungGuard AI'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          const AnimatedBackground(),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: _buildHero(context, patient, latestScan),
                ),
                SliverToBoxAdapter(child: _buildPrograms(programs)),
                SliverToBoxAdapter(child: _buildInsights(insights)),
                SliverToBoxAdapter(child: _buildTimeline(timelineEvents)),
                const SliverToBoxAdapter(child: SizedBox(height: 48)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHero(BuildContext context, patient, latestScan) {
    final scheme = Theme.of(context).colorScheme;
    final horizontal = Breakpoints.horizontalPadding(context);
    final vertical = Breakpoints.verticalSpacing(context);
    return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontal,
            vertical: vertical,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                colors: [Color(0xFF121C2B), Color(0xFF080D16)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _HaloPainter(animation: _haloController),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Chip(
                            backgroundColor: scheme.primary.withValues(
                              alpha: 0.15,
                            ),
                            side: BorderSide.none,
                            label: Text(
                              'Quantum-grade detection',
                              style: TextStyle(
                                color: scheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                          .animate()
                          .fadeIn(duration: 400.ms)
                          .scale(
                            delay: 100.ms,
                            duration: 300.ms,
                            curve: Curves.easeOutBack,
                          ),
                      const SizedBox(height: 16),
                      Text(
                            'Hi ${patient.name.split(' ').first},\nYour lungs are monitored in real-time.',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          )
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 200.ms)
                          .slideY(begin: 0.1, end: 0),
                      const SizedBox(height: 12),
                      Text(
                        'Latest scan: ${latestScan.status} • ${latestScan.confidence.toStringAsFixed(1)}% confidence',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                      ).animate().fadeIn(duration: 400.ms, delay: 400.ms),
                      const SizedBox(height: 24),
                      Wrap(
                        spacing: 16,
                        runSpacing: 12,
                        children: [
                          HeroStat(
                                label: 'Nodule tracking',
                                value: '${latestScan.nodules.length} detected',
                              )
                              .animate()
                              .fadeIn(duration: 400.ms, delay: 500.ms)
                              .slideY(begin: 0.1, end: 0),
                          HeroStat(
                                label: 'Respiratory score',
                                value: '${patient.respiratoryScore} / 100',
                              )
                              .animate()
                              .fadeIn(duration: 400.ms, delay: 600.ms)
                              .slideY(begin: 0.1, end: 0),
                          HeroStat(
                                label: 'AI confidence',
                                value:
                                    '${latestScan.confidence.toStringAsFixed(1)}%',
                              )
                              .animate()
                              .fadeIn(duration: 400.ms, delay: 700.ms)
                              .slideY(begin: 0.1, end: 0),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: scheme.primary,
                                    foregroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      AppTheme.fadeRoute(
                                        const DetectionWorkflowScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text('Start live detection'),
                                ),
                              )
                              .animate()
                              .fadeIn(duration: 400.ms, delay: 600.ms)
                              .scale(
                                delay: 600.ms,
                                duration: 300.ms,
                                curve: Curves.easeOutBack,
                              ),
                          const SizedBox(width: 12),
                          OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  side: BorderSide(
                                    color: Colors.white.withValues(alpha: 0.2),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    AppTheme.fadeRoute(
                                      const InsightsHistoryScreen(),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.auto_graph_rounded),
                                label: const Text('Insights'),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .scale(delay: 100.ms, duration: 500.ms, curve: Curves.easeOutBack);
  }

  Widget _buildPrograms(List<Map<String, dynamic>> programs) {
    final horizontal = Breakpoints.horizontalPadding(context);
    final cardHeight = Breakpoints.cardHeight(context);
    return Padding(
      padding: EdgeInsets.only(
        top: 12,
        bottom: 32,
        left: horizontal,
        right: horizontal,
      ),
      child: SizedBox(
        height: cardHeight,
        child: PageView.builder(
          controller: _programController,
          itemCount: programs.length,
          padEnds: false,
          itemBuilder: (context, index) {
            final data = programs[index];
            return AnimatedBuilder(
              animation: _programController,
              builder: (context, child) {
                double value = 0;
                if (_programController.position.haveDimensions) {
                  value = _programController.page! - index;
                  value = (1 - (value.abs() * 0.2)).clamp(0.8, 1.0);
                }
                return Transform.scale(scale: value, child: child);
              },
              child: Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 20 : 12,
                  right: index == programs.length - 1 ? 20 : 12,
                ),
                child: ProgramCard(
                  title: data['title'] as String,
                  description: data['description'] as String,
                  accuracy: data['accuracy'] as double,
                  gradient: data['gradient'] as List<Color>,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInsights(List<Map<String, dynamic>> insights) {
    final horizontal = Breakpoints.horizontalPadding(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Precision insights',
            style: Theme.of(context).textTheme.titleLarge,
          ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0),
          const SizedBox(height: 12),
          ...insights.asMap().entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InsightCard(
                label: entry.value['label'] as String,
                value: entry.value['value'] as String,
                detail: entry.value['detail'] as String,
                icon: entry.value['icon'] as IconData,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(List<Map<String, dynamic>> events) {
    final horizontal = Breakpoints.horizontalPadding(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(horizontal, 24, horizontal, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Today\'s telemetry',
            style: Theme.of(context).textTheme.titleLarge,
          ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              gradient: const LinearGradient(
                colors: [Color(0xFF0E1522), Color(0xFF080D16)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: events
                  .asMap()
                  .entries
                  .map(
                    (entry) =>
                        _TimelineTile(
                              time: entry.value['time'] as String,
                              title: entry.value['title'] as String,
                              detail: entry.value['subtitle'] as String,
                              icon: entry.value['icon'] as IconData,
                              isLast: entry.key == events.length - 1,
                            )
                            .animate()
                            .fadeIn(
                              duration: 400.ms,
                              delay: (entry.key * 120).ms,
                            )
                            .slideX(begin: 0.05),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _HaloPainter extends CustomPainter {
  final Animation<double> animation;

  _HaloPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final progress = animation.value;
    final center = Offset(size.width * 0.65, size.height * 0.3);
    final radius = 140 + 10 * progress;
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF47FFE0).withValues(alpha: 0.4),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 40);
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _HaloPainter oldDelegate) => true;
}

class _TimelineTile extends StatelessWidget {
  final String time;
  final String title;
  final String detail;
  final IconData icon;
  final bool isLast;

  const _TimelineTile({
    required this.time,
    required this.title,
    required this.detail,
    required this.icon,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: scheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        scheme.primary.withValues(alpha: 0.6),
                        Colors.transparent,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  detail,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.white60),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
