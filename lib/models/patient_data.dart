class PatientData {
  final String id;
  final String name;
  final String mrn;
  final int age;
  final String email;
  final String avatarInitials;
  final int genesTracked;
  final int activeProtocols;
  final int respiratoryScore;
  final RiskLevel riskLevel;
  final String scanCadence;
  final List<String> badges;
  final List<CareProvider> careCircle;
  final List<PatientDocument> documents;

  PatientData({
    required this.id,
    required this.name,
    required this.mrn,
    required this.age,
    required this.email,
    required this.avatarInitials,
    required this.genesTracked,
    required this.activeProtocols,
    required this.respiratoryScore,
    required this.riskLevel,
    required this.scanCadence,
    required this.badges,
    required this.careCircle,
    required this.documents,
  });

  factory PatientData.fromJson(Map<String, dynamic> json) {
    return PatientData(
      id: json['id'] as String,
      name: json['name'] as String,
      mrn: json['mrn'] as String,
      age: json['age'] as int,
      email: json['email'] as String,
      avatarInitials: json['avatarInitials'] as String,
      genesTracked: json['genesTracked'] as int,
      activeProtocols: json['activeProtocols'] as int,
      respiratoryScore: json['respiratoryScore'] as int,
      riskLevel: RiskLevel.fromString(json['riskLevel'] as String),
      scanCadence: json['scanCadence'] as String,
      badges: (json['badges'] as List).map((e) => e as String).toList(),
      careCircle: (json['careCircle'] as List)
          .map((e) => CareProvider.fromJson(e as Map<String, dynamic>))
          .toList(),
      documents: (json['documents'] as List)
          .map((e) => PatientDocument.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

enum RiskLevel {
  low,
  moderate,
  high,
  critical;

  static RiskLevel fromString(String value) {
    return RiskLevel.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => RiskLevel.low,
    );
  }

  String get displayName {
    switch (this) {
      case RiskLevel.low:
        return 'Low';
      case RiskLevel.moderate:
        return 'Moderate';
      case RiskLevel.high:
        return 'High';
      case RiskLevel.critical:
        return 'Critical';
    }
  }
}

class CareProvider {
  final String id;
  final String name;
  final String role;
  final String avatarInitials;

  CareProvider({
    required this.id,
    required this.name,
    required this.role,
    required this.avatarInitials,
  });

  factory CareProvider.fromJson(Map<String, dynamic> json) {
    return CareProvider(
      id: json['id'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      avatarInitials: json['avatarInitials'] as String,
    );
  }
}

class PatientDocument {
  final String id;
  final String title;
  final String subtitle;
  final DateTime updatedAt;

  PatientDocument({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.updatedAt,
  });

  factory PatientDocument.fromJson(Map<String, dynamic> json) {
    return PatientDocument(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}

