import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData(useMaterial3: true, brightness: Brightness.dark);
    final scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF5DE0E6),
      brightness: Brightness.dark,
    );

    return MaterialApp(
      title: 'LungGuard AI',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: base.copyWith(
        colorScheme: scheme,
        scaffoldBackgroundColor: const Color(0xFF02060E),
        textTheme: GoogleFonts.interTextTheme(base.textTheme),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      home: const OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  final _slides = const [
    _OnboardingSlide(
      title: 'Quantum Lung Intelligence',
      subtitle: 'CT + breathomics fusion for early-stage detection.',
      icon: Icons.data_usage_rounded,
      badge: 'AI Co-Pilot',
    ),
    _OnboardingSlide(
      title: 'Continuous Digital Twin',
      subtitle: 'Every breath, pulse and habit updated in real-time.',
      icon: Icons.monitor_heart_rounded,
      badge: 'Live Biometrics',
    ),
    _OnboardingSlide(
      title: 'Care Circle Synced',
      subtitle: 'Clinicians + AI collaborate to plan precision care.',
      icon: Icons.handshake_rounded,
      badge: 'Care Network',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isWide = _Breakpoints.isTablet(context);
    return Scaffold(
      body: Stack(
        children: [
          const _AnimatedBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _controller,
                      onPageChanged: (value) => setState(() => _page = value),
                      itemCount: _slides.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Align(
                          alignment:
                              isWide ? Alignment.center : Alignment.center,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: isWide ? 640 : double.infinity,
                            ),
                            child: _OnboardingSlideCard(slide: _slides[index]),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _slides.length,
                      (index) => AnimatedContainer(
                        duration: 300.ms,
                        margin: const EdgeInsets.all(6),
                        height: 6,
                        width: index == _page ? 32 : 12,
                        decoration: BoxDecoration(
                          color: index == _page ? scheme.primary : Colors.white24,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                        backgroundColor: scheme.primary,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        if (_page == _slides.length - 1) {
                          Navigator.of(context).pushReplacement(
                            _fadeRoute(const AppShell()),
                          );
                        } else {
                          _controller.nextPage(
                            duration: 400.ms,
                            curve: Curves.easeOutCubic,
                          );
                        }
                      },
                      child: Text(
                        _page == _slides.length - 1 ? 'Enter LungGuard' : 'Continue',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _OnboardingSlide {
  final String title;
  final String subtitle;
  final IconData icon;
  final String badge;

  const _OnboardingSlide({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.badge,
  });
}

class _OnboardingSlideCard extends StatelessWidget {
  final _OnboardingSlide slide;

  const _OnboardingSlideCard({required this.slide});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          colors: [Color(0xFF111D2F), Color(0xFF05070C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Chip(
              label: Text(slide.badge),
              visualDensity: VisualDensity.compact,
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1B8AF2), Color(0xFF7F7FD5)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 30,
                      offset: const Offset(0, 20),
                    )
                  ],
                ),
                child: Icon(
                  slide.icon,
                  size: 96,
                  color: Colors.white,
                ),
              ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            slide.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            slide.subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

Route _fadeRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, animation, __, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

class _Breakpoints {
  static Size _size(BuildContext context) => MediaQuery.sizeOf(context);

  static bool isTablet(BuildContext context) => _size(context).width >= 768;

  static bool isDesktop(BuildContext context) => _size(context).width >= 1100;

  static double horizontalPadding(BuildContext context) {
    if (isDesktop(context)) return 56;
    if (isTablet(context)) return 32;
    return 20;
  }

  static double verticalSpacing(BuildContext context) =>
      isTablet(context) ? 24 : 16;

  static int gridColumns(BuildContext context, {int mobile = 2}) {
    final width = _size(context).width;
    if (width >= 1300) return 4;
    if (width >= 900) return 3;
    return mobile;
  }

  static double cardHeight(BuildContext context) =>
      isDesktop(context) ? 340 : (isTablet(context) ? 300 : 260);
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      const OverviewScreen(),
      const DetectionWorkflowScreen(),
      const CarePlanScreen(),
      const PatientProfileScreen(),
    ];

    return Scaffold(
      body: AnimatedSwitcher(
        duration: 400.ms,
        child: screens[_index],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: NavigationBar(
            indicatorColor: Theme.of(context).colorScheme.primaryContainer,
            selectedIndex: _index,
            onDestinationSelected: (value) => setState(() => _index = value),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard_rounded),
                label: 'Overview',
              ),
              NavigationDestination(
                icon: Icon(Icons.biotech_outlined),
                selectedIcon: Icon(Icons.biotech_rounded),
                label: 'Detect',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_outline),
                selectedIcon: Icon(Icons.favorite),
                label: 'Care',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen>
    with TickerProviderStateMixin {
  late final AnimationController _haloController;
  late final PageController _programController;

  final _programs = const [
    _ProgramCardData(
      title: 'High-Res CT Insight',
      description: 'Volumetric overlays verified by oncology board.',
      accuracy: 98.6,
      gradient: [Color(0xFF43CBFF), Color(0xFF9708CC)],
    ),
    _ProgramCardData(
      title: 'Breath Biomarker Lab',
      description: 'Exhaled VOC nano-sensor analytics.',
      accuracy: 94.2,
      gradient: [Color(0xFF6EE2F5), Color(0xFF6454F0)],
    ),
    _ProgramCardData(
      title: 'Preventive Coaching',
      description: 'Digital twin forecasts & lifestyle nudges.',
      accuracy: 91.8,
      gradient: [Color(0xFF0BA360), Color(0xFF3CBA92)],
    ),
  ];

  final _insights = const [
    _RiskInsight(
      label: 'Risk level',
      value: 'Low (12%)',
      detail: 'No nodular growth in last 6 months.',
      icon: Icons.shield_moon_outlined,
    ),
    _RiskInsight(
      label: 'Scan cadence',
      value: 'Every 90 days',
      detail: 'Adaptive schedule + clinician override.',
      icon: Icons.calendar_month_outlined,
    ),
    _RiskInsight(
      label: 'Lifestyle impact',
      value: '+34%',
      detail: 'Respiratory capacity vs baseline.',
      icon: Icons.trending_up_rounded,
    ),
  ];

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
          const _AnimatedBackground(),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildHero(context)),
                SliverToBoxAdapter(child: _buildPrograms()),
                SliverToBoxAdapter(child: _buildInsights()),
                SliverToBoxAdapter(child: _buildTimeline()),
                const SliverToBoxAdapter(child: SizedBox(height: 48)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final horizontal = _Breakpoints.horizontalPadding(context);
    final vertical = _Breakpoints.verticalSpacing(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
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
                    backgroundColor: scheme.primary.withValues(alpha: 0.15),
                    side: BorderSide.none,
                    label: Text(
                      'Quantum-grade detection',
                      style: TextStyle(
                        color: scheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Hi Alina,\nYour lungs are monitored in real-time.',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ).animate().fadeIn(duration: 600.ms).slideY(),
                  const SizedBox(height: 12),
                  Text(
                    'Next precision scan window opens in 02:14:22.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 16,
                    runSpacing: 12,
                    children: const [
                      _HeroStat(label: 'Nodule tracking', value: '0 growth'),
                      _HeroStat(label: 'Respiratory score', value: '92 / 100'),
                      _HeroStat(label: 'AI confidence', value: '99.2%'),
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
                              _fadeRoute(const DetectionWorkflowScreen()),
                            );
                          },
                          child: const Text('Start live detection'),
                        ),
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
                            _fadeRoute(const InsightsHistoryScreen()),
                          );
                        },
                        icon: const Icon(Icons.auto_graph_rounded),
                        label: const Text('Insights'),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: scheme.primary.withValues(alpha: 0.3),
                        ),
                        gradient: RadialGradient(
                          colors: [
                            scheme.primary.withValues(alpha: 0.25),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Icon(
                        Icons.health_and_safety_rounded,
                        size: 64,
                        color: scheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrograms() {
    final horizontal = _Breakpoints.horizontalPadding(context);
    final cardHeight = _Breakpoints.cardHeight(context);
    return Padding(
      padding:
          EdgeInsets.only(top: 12, bottom: 32, left: horizontal, right: horizontal),
      child: SizedBox(
        height: cardHeight,
        child: PageView.builder(
          controller: _programController,
          itemCount: _programs.length,
          padEnds: false,
          itemBuilder: (context, index) {
            final data = _programs[index];
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
                  right: index == _programs.length - 1 ? 20 : 12,
                ),
                child: _ProgramCard(data: data),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInsights() {
    final horizontal = _Breakpoints.horizontalPadding(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Precision insights',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          ..._insights.map(
            (insight) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _InsightCard(insight: insight),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    final events = [
      _TimelineEvent(
        time: '09:30',
        title: 'Breath biomarkers synced',
        detail: 'CO₂ variance -0.4% vs last week',
        statusColor: Colors.tealAccent,
      ),
      _TimelineEvent(
        time: '12:10',
        title: 'CT scan review finalized',
        detail: 'Radiologist double-checked AI overlay',
        statusColor: Colors.lightBlueAccent,
      ),
      _TimelineEvent(
        time: '18:45',
        title: 'Preventive protocol update',
        detail: 'New mindfulness routine added',
        statusColor: Colors.purpleAccent,
      ),
    ];

    final horizontal = _Breakpoints.horizontalPadding(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(horizontal, 24, horizontal, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Today\'s telemetry',
            style: Theme.of(context).textTheme.titleLarge,
          ),
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
                  .map((event) => _TimelineTile(event: event))
                  .toList()
                  .animate(interval: 120.ms)
                  .fadeIn(duration: 400.ms)
                  .slideX(begin: 0.05),
            ),
          ),
        ],
      ),
    );
  }
}

class DetectionWorkflowScreen extends StatefulWidget {
  const DetectionWorkflowScreen({super.key});

  @override
  State<DetectionWorkflowScreen> createState() =>
      _DetectionWorkflowScreenState();
}

class _DetectionWorkflowScreenState extends State<DetectionWorkflowScreen> {
  int stage = 1;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final horizontal = _Breakpoints.horizontalPadding(context);
    final stages = [
      _DetectionStage(
        title: 'Upload CT / PET',
        subtitle: 'DICOM validated • contrast optimized',
        icon: Icons.cloud_upload_outlined,
        complete: stage > 0,
      ),
      _DetectionStage(
        title: 'AI volumetric scan',
        subtitle: '7.8M voxel pairs compared',
        icon: Icons.hub_outlined,
        complete: stage > 1,
      ),
      _DetectionStage(
        title: 'Clinician review',
        subtitle: 'Augmented overlay pushed to XR room',
        icon: Icons.health_and_safety_outlined,
        complete: stage > 2,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detection workflow'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('History'),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(horizontal, 8, horizontal, 32),
        children: [
          _GlassCard(
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
                      child: Icon(Icons.biotech_rounded, color: scheme.primary),
                    ),
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
                          ),
                          Text(
                            'confidence index 99.2% • v3.1 quantum core',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings_backup_restore_rounded),
                      onPressed: () => setState(
                        () => stage = stage == 3 ? 1 : stage + 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(52),
                          backgroundColor: scheme.primary,
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.cloud_upload_rounded),
                        label: const Text('Upload scan'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(52),
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.camera_indoor_outlined),
                        label: const Text('Live CT link'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ...stages.map(
            (stageData) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _ProcessTile(stage: stageData),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Live biomarkers',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              final cards = const [
                _VitalsCard(
                  label: 'Breath VOC delta',
                  value: '-0.4%',
                  detail: 'vs last week',
                  sparkline: [0.3, 0.2, 0.25, 0.15, 0.12],
                ),
                _VitalsCard(
                  label: 'Resp. rhythm',
                  value: '16 bpm',
                  detail: 'steady variance',
                  sparkline: [0.1, 0.15, 0.2, 0.18, 0.16],
                ),
                _VitalsCard(
                  label: 'Blood oxygen',
                  value: '98%',
                  detail: 'wearable mesh',
                  sparkline: [0.9, 0.92, 0.95, 0.94, 0.96],
                ),
                _VitalsCard(
                  label: 'Exhaled temp',
                  value: '33.2°C',
                  detail: 'optimal range',
                  sparkline: [0.25, 0.28, 0.22, 0.24, 0.27],
                ),
              ];

              final computed = _Breakpoints.gridColumns(context, mobile: 2);
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

class CarePlanScreen extends StatelessWidget {
  const CarePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontal = _Breakpoints.horizontalPadding(context);
    final appointments = [
      _AppointmentPlan(
        title: 'Preventive pulmonology',
        clinician: 'Dr. Mira Sethi',
        date: 'Feb 12 • 10:00 AM',
        location: 'Oncology Hybrid Lab',
        accent: const [Color(0xFF7F7FD5), Color(0xFF86A8E7)],
      ),
      _AppointmentPlan(
        title: 'Breathomics coaching',
        clinician: 'Coach Liam',
        date: 'Feb 15 • 06:30 PM',
        location: 'Remote / XR session',
        accent: const [Color(0xFF0BA360), Color(0xFF34A853)],
      ),
    ];

    final tasks = [
      _CareTask('Pranayama routine', '92% adherence'),
      _CareTask('Micro-nutrition log', 'Completed today'),
      _CareTask('Sleep sync', 'Last synced 3h ago'),
    ];

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
          ),
          const SizedBox(height: 16),
          ...appointments.map(
            (appt) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _AppointmentCard(appointment: appt),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Daily rituals',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          ...tasks.map(
            (task) => ListTile(
              tileColor: Colors.white.withValues(alpha: 0.02),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: BorderSide(
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
              leading: const Icon(Icons.verified_rounded, color: Colors.teal),
              title: Text(task.title),
              subtitle: Text(task.subtitle),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 24),
          _GlassCard(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Need human support?',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Certified coaches, pulmonologists & nutritionists reply under 5 min.',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: () {},
                  child: const Text('Open lounge'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PatientProfileScreen extends StatelessWidget {
  const PatientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontal = _Breakpoints.horizontalPadding(context);
    final metrics = const [
      _HeroStat(label: 'Age', value: '32'),
      _HeroStat(label: 'Genes tracked', value: '48'),
      _HeroStat(label: 'Protocols', value: '4 active'),
      _HeroStat(label: 'Resp. score', value: '92 / 100'),
    ];

    final documents = [
      _PatientDoc('Precision CT overlay', 'Updated 2 days ago'),
      _PatientDoc('Clinician notes', 'Dr. Sethi • Feb 02'),
      _PatientDoc('Lifestyle journal', 'Synced via wearable'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner_rounded),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {},
          ),
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
                child: const Center(
                  child: Text(
                    'AL',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alina Kapadia',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'MRN · LG-92831-5',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white70),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 10,
                      children: const [
                        Chip(
                          label: Text('Digital twin v4'),
                          visualDensity: VisualDensity.compact,
                        ),
                        Chip(
                          label: Text('Breathomics beta'),
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: metrics,
          ),
          const SizedBox(height: 24),
          Text(
            'Care circle',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              final isStacked = constraints.maxWidth < 640;
              final tiles = [
                _CareCircleTile(
                  title: 'Dr. Mira Sethi',
                  subtitle: 'Lead pulmonologist',
                  avatarLetter: 'MS',
                  expanded: !isStacked,
                ),
                _CareCircleTile(
                  title: 'Coach Liam',
                  subtitle: 'Breath mentor',
                  avatarLetter: 'CL',
                  expanded: !isStacked,
                ),
              ];

              if (isStacked) {
                return Column(
                  children: [
                    ...tiles.map(
                      (tile) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: SizedBox(
                          width: double.infinity,
                          child: tile,
                        ),
                      ),
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  tiles.first,
                  const SizedBox(width: 12),
                  tiles.last,
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          Text(
            'Documents',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          ...documents.map(
            (doc) => ListTile(
              tileColor: Colors.white.withValues(alpha: 0.02),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: BorderSide(
                  color: Colors.white.withValues(alpha: 0.04),
                ),
              ),
              leading: const Icon(Icons.description_outlined),
              title: Text(doc.title),
              subtitle: Text(doc.subtitle),
              trailing: const Icon(Icons.download_rounded),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Sign out'),
          ),
        ],
      ),
    );
  }
}

class InsightsHistoryScreen extends StatelessWidget {
  const InsightsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = [
      _InsightHistory(
        title: 'No malignant signature',
        subtitle: 'CT fusion • Feb 03',
        trend: '+0.2% accuracy vs last scan',
      ),
      _InsightHistory(
        title: 'Inflammation decreasing',
        subtitle: 'Biomarkers • Jan 28',
        trend: '-4.3% hs-CRP vs baseline',
      ),
      _InsightHistory(
        title: 'Lifestyle uplift',
        subtitle: 'Behavior twin • Jan 21',
        trend: '+8% respiratory capacity',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Insights archive'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          return Card(
            color: Colors.white.withValues(alpha: 0.03),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.2),
                child: const Icon(Icons.auto_graph_rounded),
              ),
              title: Text(item.title),
              subtitle: Text(item.subtitle),
              trailing: Text(
                item.trend,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}

// Shared building blocks -------------------------------------------------

class _AnimatedBackground extends StatefulWidget {
  const _AnimatedBackground();

  @override
  State<_AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<_AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0.2 * (1 - t), -0.6 + t * 0.8),
              colors: const [Color(0xFF132237), Color(0xFF060B13)],
              radius: 1.2,
            ),
          ),
        );
      },
    );
  }
}

class _GlassCard extends StatelessWidget {
  final Widget child;

  const _GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
        color: Colors.white.withValues(alpha: 0.02),
      ),
      child: child,
    );
  }
}

class _HeroStat extends StatelessWidget {
  final String label;
  final String value;

  const _HeroStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}

class _ProgramCardData {
  final String title;
  final String description;
  final double accuracy;
  final List<Color> gradient;

  const _ProgramCardData({
    required this.title,
    required this.description,
    required this.accuracy,
    required this.gradient,
  });
}

class _ProgramCard extends StatelessWidget {
  final _ProgramCardData data;

  const _ProgramCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: data.gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: data.gradient.last.withValues(alpha: 0.4),
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
              Icons.medical_services_outlined,
              color: Colors.white.withValues(alpha: 0.9),
              size: 32,
            ),
            const Spacer(),
            Text(
              data.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              data.description,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white70),
            ),
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
                    'Accuracy ${data.accuracy.toStringAsFixed(1)}%',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_rounded, color: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RiskInsight {
  final String label;
  final String value;
  final String detail;
  final IconData icon;

  const _RiskInsight({
    required this.label,
    required this.value,
    required this.detail,
    required this.icon,
  });
}

class _InsightCard extends StatelessWidget {
  final _RiskInsight insight;

  const _InsightCard({required this.insight});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
        color: Colors.white.withValues(alpha: 0.02),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.08),
            ),
            child: Icon(insight.icon, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  insight.label,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 4),
                Text(
                  insight.value,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  insight.detail,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white60),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: Colors.white54),
        ],
      ),
    );
  }
}

class _TimelineEvent {
  final String time;
  final String title;
  final String detail;
  final Color statusColor;

  const _TimelineEvent({
    required this.time,
    required this.title,
    required this.detail,
    required this.statusColor,
  });
}

class _TimelineTile extends StatelessWidget {
  final _TimelineEvent event;

  const _TimelineTile({required this.event});

  @override
  Widget build(BuildContext context) {
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
                  color: event.statusColor,
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 2,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      event.statusColor.withValues(alpha: 0.6),
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
                  event.time,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 4),
                Text(
                  event.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  event.detail,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white60),
                ),
              ],
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

class _DetectionStage {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool complete;

  const _DetectionStage({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.complete = false,
  });
}

class _ProcessTile extends StatelessWidget {
  final _DetectionStage stage;

  const _ProcessTile({required this.stage});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
        color: Colors.white.withValues(alpha: 0.02),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: stage.complete
                  ? scheme.primary.withValues(alpha: 0.2)
                  : Colors.white.withValues(alpha: 0.05),
            ),
            child: Icon(
              stage.icon,
              color: stage.complete ? scheme.primary : Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stage.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  stage.subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
          Icon(
            stage.complete ? Icons.check_circle : Icons.timelapse,
            color: stage.complete ? scheme.primary : Colors.white54,
          ),
        ],
      ),
    );
  }
}

class _VitalsCard extends StatelessWidget {
  final String label;
  final String value;
  final String detail;
  final List<double> sparkline;

  const _VitalsCard({
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
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            detail,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.white60),
          ),
          const Spacer(),
          SizedBox(
            height: 32,
            child: CustomPaint(
              painter: _SparklinePainter(points: sparkline),
            ),
          ),
        ],
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final List<double> points;

  _SparklinePainter({required this.points});

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
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) =>
      oldDelegate.points != points;
}

class _AppointmentPlan {
  final String title;
  final String clinician;
  final String date;
  final String location;
  final List<Color> accent;

  const _AppointmentPlan({
    required this.title,
    required this.clinician,
    required this.date,
    required this.location,
    required this.accent,
  });
}

class _AppointmentCard extends StatelessWidget {
  final _AppointmentPlan appointment;

  const _AppointmentCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: LinearGradient(
          colors: appointment.accent,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appointment.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            appointment.clinician,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              const Icon(Icons.schedule_rounded),
              const SizedBox(width: 8),
              Text(appointment.date),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.location_on_outlined),
              const SizedBox(width: 8),
              Text(appointment.location),
            ],
          ),
          const SizedBox(height: 18),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Open briefing'),
            ),
          ),
        ],
      ),
    );
  }
}

class _CareTask {
  final String title;
  final String subtitle;

  const _CareTask(this.title, this.subtitle);
}

class _CareCircleTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String avatarLetter;
  final bool expanded;

  const _CareCircleTile({
    required this.title,
    required this.subtitle,
    required this.avatarLetter,
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
            child: Text(avatarLetter),
          ),
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
                ),
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
        ],
      ),
    );

    if (expanded) {
      return Expanded(child: content);
    }
    return content;
  }
}

class _PatientDoc {
  final String title;
  final String subtitle;

  _PatientDoc(this.title, this.subtitle);
}

class _InsightHistory {
  final String title;
  final String subtitle;
  final String trend;

  _InsightHistory({
    required this.title,
    required this.subtitle,
    required this.trend,
  });
}

