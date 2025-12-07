import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/animated_background.dart';
import '../utils/breakpoints.dart';
import '../theme/app_theme.dart';
import 'app_shell.dart';

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
    final isWide = Breakpoints.isTablet(context);
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedBackground(),
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
                          alignment: isWide
                              ? Alignment.center
                              : Alignment.center,
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
                          color: index == _page
                              ? scheme.primary
                              : Colors.white24,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 24,
                    ),
                    child:
                        FilledButton(
                              style: FilledButton.styleFrom(
                                minimumSize: const Size.fromHeight(56),
                                backgroundColor: scheme.primary,
                                foregroundColor: Colors.black,
                              ),
                              onPressed: () {
                                if (_page == _slides.length - 1) {
                                  Navigator.of(context).pushReplacement(
                                    AppTheme.fadeRoute(const AppShell()),
                                  );
                                } else {
                                  _controller.nextPage(
                                    duration: 400.ms,
                                    curve: Curves.easeOutCubic,
                                  );
                                }
                              },
                              child: Text(
                                _page == _slides.length - 1
                                    ? 'Enter LungGuard'
                                    : 'Continue',
                              ),
                            )
                            .animate()
                            .fadeIn(duration: 400.ms)
                            .scale(
                              delay: 200.ms,
                              duration: 300.ms,
                              curve: Curves.easeOutBack,
                            ),
                  ),
                ],
              ),
            ),
          ),
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
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            gradient: const LinearGradient(
              colors: [Color(0xFF0E1522), Color(0xFF080D16)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Chip(
                  label: Text(slide.badge),
                  visualDensity: VisualDensity.compact,
                ),
              ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2, end: 0),
              Expanded(
                child: Center(
                  child:
                      Container(
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
                                ),
                              ],
                            ),
                            child: Icon(
                              slide.icon,
                              size: 96,
                              color: Colors.white,
                            ),
                          )
                          .animate()
                          .scale(duration: 600.ms, curve: Curves.easeOutBack)
                          .shimmer(duration: 2000.ms, delay: 600.ms),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                    slide.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 200.ms)
                  .slideY(begin: 0.2, end: 0),
              const SizedBox(height: 8),
              Text(
                    slide.subtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                  )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 300.ms)
                  .slideY(begin: 0.2, end: 0),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .scale(delay: 100.ms, duration: 500.ms, curve: Curves.easeOutBack);
  }
}
