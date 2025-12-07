import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'overview_screen.dart';
import 'detection_workflow_screen.dart';
import 'care_plan_screen.dart';
import 'patient_profile_screen.dart';

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
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(0.05, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
              child: child,
            ),
          );
        },
        child: screens[_index],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child:
              NavigationBar(
                    indicatorColor: Theme.of(
                      context,
                    ).colorScheme.primaryContainer,
                    selectedIndex: _index,
                    onDestinationSelected: (value) =>
                        setState(() => _index = value),
                    backgroundColor: Colors.white.withValues(alpha: 0.05),
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
                  )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 200.ms)
                  .slideY(begin: 0.2, end: 0),
        ),
      ),
    );
  }
}
