import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../data/dummy_data_service.dart';

class InsightsHistoryScreen extends StatelessWidget {
  const InsightsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _dataService = DummyDataService();
    final history = _dataService.getInsightHistory();

    return Scaffold(
      appBar: AppBar(title: const Text('Insights archive')),
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
                  leading:
                      CircleAvatar(
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.2),
                        child: Icon(
                          item['icon'] as IconData,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ).animate().scale(
                        duration: 400.ms,
                        curve: Curves.easeOutBack,
                      ),
                  title: Text(item['title'] as String),
                  subtitle: Text(item['subtitle'] as String),
                  trailing: Text(
                    item['trend'] as String,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  onTap: () {},
                ),
              )
              .animate()
              .fadeIn(duration: 400.ms, delay: (index * 100).ms)
              .slideX(begin: 0.1, end: 0)
              .scale(
                delay: (index * 100 + 50).ms,
                duration: 300.ms,
                curve: Curves.easeOutBack,
              );
        },
      ),
    );
  }
}
