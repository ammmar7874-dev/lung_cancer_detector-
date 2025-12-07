class ScanResult {
  final String id;
  final DateTime scanDate;
  final String scanType; // CT, PET, etc.
  final double confidence;
  final String status; // Normal, Suspicious, Malignant
  final Map<String, dynamic> findings;
  final List<Nodule> nodules;
  final BiomarkerData biomarkers;
  final String reportUrl;

  ScanResult({
    required this.id,
    required this.scanDate,
    required this.scanType,
    required this.confidence,
    required this.status,
    required this.findings,
    required this.nodules,
    required this.biomarkers,
    required this.reportUrl,
  });

  factory ScanResult.fromJson(Map<String, dynamic> json) {
    return ScanResult(
      id: json['id'] as String,
      scanDate: DateTime.parse(json['scanDate'] as String),
      scanType: json['scanType'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      status: json['status'] as String,
      findings: json['findings'] as Map<String, dynamic>,
      nodules: (json['nodules'] as List)
          .map((n) => Nodule.fromJson(n as Map<String, dynamic>))
          .toList(),
      biomarkers: BiomarkerData.fromJson(json['biomarkers'] as Map<String, dynamic>),
      reportUrl: json['reportUrl'] as String,
    );
  }
}

class Nodule {
  final String id;
  final String location;
  final double size; // in mm
  final String shape;
  final double malignancyProbability;
  final String recommendation;

  Nodule({
    required this.id,
    required this.location,
    required this.size,
    required this.shape,
    required this.malignancyProbability,
    required this.recommendation,
  });

  factory Nodule.fromJson(Map<String, dynamic> json) {
    return Nodule(
      id: json['id'] as String,
      location: json['location'] as String,
      size: (json['size'] as num).toDouble(),
      shape: json['shape'] as String,
      malignancyProbability: (json['malignancyProbability'] as num).toDouble(),
      recommendation: json['recommendation'] as String,
    );
  }
}

class BiomarkerData {
  final double breathVOC;
  final double respiratoryRate;
  final double bloodOxygen;
  final double exhaledTemp;
  final double hsCRP;
  final List<double> vocHistory;
  final List<double> respiratoryHistory;
  final List<double> oxygenHistory;
  final List<double> tempHistory;

  BiomarkerData({
    required this.breathVOC,
    required this.respiratoryRate,
    required this.bloodOxygen,
    required this.exhaledTemp,
    required this.hsCRP,
    required this.vocHistory,
    required this.respiratoryHistory,
    required this.oxygenHistory,
    required this.tempHistory,
  });

  factory BiomarkerData.fromJson(Map<String, dynamic> json) {
    return BiomarkerData(
      breathVOC: (json['breathVOC'] as num).toDouble(),
      respiratoryRate: (json['respiratoryRate'] as num).toDouble(),
      bloodOxygen: (json['bloodOxygen'] as num).toDouble(),
      exhaledTemp: (json['exhaledTemp'] as num).toDouble(),
      hsCRP: (json['hsCRP'] as num).toDouble(),
      vocHistory: (json['vocHistory'] as List).map((e) => (e as num).toDouble()).toList(),
      respiratoryHistory: (json['respiratoryHistory'] as List).map((e) => (e as num).toDouble()).toList(),
      oxygenHistory: (json['oxygenHistory'] as List).map((e) => (e as num).toDouble()).toList(),
      tempHistory: (json['tempHistory'] as List).map((e) => (e as num).toDouble()).toList(),
    );
  }
}

