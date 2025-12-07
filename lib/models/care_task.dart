class CareTask {
  final String id;
  final String title;
  final String subtitle;
  final double adherence;
  final bool completed;
  final DateTime? lastSynced;

  CareTask({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.adherence,
    required this.completed,
    this.lastSynced,
  });

  String get adherenceText {
    if (completed) return 'Completed today';
    if (lastSynced != null) {
      final hours = DateTime.now().difference(lastSynced!).inHours;
      if (hours < 1) return 'Synced just now';
      if (hours < 24) return 'Last synced ${hours}h ago';
      final days = hours ~/ 24;
      return 'Last synced ${days}d ago';
    }
    return '${adherence.toStringAsFixed(0)}% adherence';
  }
}

