class Appointment {
  final String id;
  final String title;
  final String clinician;
  final DateTime dateTime;
  final String location;
  final AppointmentType type;
  final List<Color> accentColors;

  Appointment({
    required this.id,
    required this.title,
    required this.clinician,
    required this.dateTime,
    required this.location,
    required this.type,
    required this.accentColors,
  });

  String get formattedDate {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final month = months[dateTime.month - 1];
    final hour = dateTime.hour;
    final minute = dateTime.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    final displayMinute = minute.toString().padLeft(2, '0');
    return '$month ${dateTime.day} • $displayHour:$displayMinute $period';
  }
}

enum AppointmentType {
  preventive,
  coaching,
  consultation,
  scan;

  static AppointmentType fromString(String value) {
    return AppointmentType.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => AppointmentType.consultation,
    );
  }
}

