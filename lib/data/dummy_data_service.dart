import 'package:flutter/material.dart';
import '../models/scan_result.dart';
import '../models/patient_data.dart';
import '../models/appointment.dart';
import '../models/care_task.dart';

class DummyDataService {
  static final DummyDataService _instance = DummyDataService._internal();
  factory DummyDataService() => _instance;
  DummyDataService._internal();

  // Patient Data
  PatientData getCurrentPatient() {
    return PatientData(
      id: 'patient_001',
      name: 'Alina Kapadia',
      mrn: 'LG-92831-5',
      age: 32,
      email: 'alina.kapadia@example.com',
      avatarInitials: 'AK',
      genesTracked: 48,
      activeProtocols: 4,
      respiratoryScore: 92,
      riskLevel: RiskLevel.low,
      scanCadence: 'Every 90 days',
      badges: ['Digital twin v4', 'Breathomics beta'],
      careCircle: [
        CareProvider(
          id: 'provider_001',
          name: 'Dr. Mira Sethi',
          role: 'Lead pulmonologist',
          avatarInitials: 'MS',
        ),
        CareProvider(
          id: 'provider_002',
          name: 'Coach Liam',
          role: 'Breath mentor',
          avatarInitials: 'CL',
        ),
      ],
      documents: [
        PatientDocument(
          id: 'doc_001',
          title: 'Precision CT overlay',
          subtitle: 'Updated 2 days ago',
          updatedAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        PatientDocument(
          id: 'doc_002',
          title: 'Clinician notes',
          subtitle: 'Dr. Sethi • Feb 02',
          updatedAt: DateTime(2024, 2, 2),
        ),
        PatientDocument(
          id: 'doc_003',
          title: 'Lifestyle journal',
          subtitle: 'Synced via wearable',
          updatedAt: DateTime.now().subtract(const Duration(hours: 3)),
        ),
      ],
    );
  }

  // Latest Scan Result
  ScanResult getLatestScanResult() {
    return ScanResult(
      id: 'scan_001',
      scanDate: DateTime.now().subtract(const Duration(days: 5)),
      scanType: 'High-Res CT',
      confidence: 98.6,
      status: 'Normal',
      findings: {
        'nodulesFound': 0,
        'suspiciousAreas': 0,
        'lungVolume': 5.2,
        'airwayHealth': 'Optimal',
        'pleuralStatus': 'Normal',
      },
      nodules: [],
      biomarkers: BiomarkerData(
        breathVOC: -0.4,
        respiratoryRate: 16.0,
        bloodOxygen: 98.0,
        exhaledTemp: 33.2,
        hsCRP: 1.2,
        vocHistory: [0.3, 0.2, 0.25, 0.15, 0.12, 0.18, 0.14],
        respiratoryHistory: [0.1, 0.15, 0.2, 0.18, 0.16, 0.17, 0.16],
        oxygenHistory: [0.9, 0.92, 0.95, 0.94, 0.96, 0.97, 0.98],
        tempHistory: [0.25, 0.28, 0.22, 0.24, 0.27, 0.26, 0.25],
      ),
      reportUrl: 'https://lungguard.ai/reports/scan_001',
    );
  }

  // Scan History
  List<ScanResult> getScanHistory() {
    return [
      ScanResult(
        id: 'scan_001',
        scanDate: DateTime.now().subtract(const Duration(days: 5)),
        scanType: 'High-Res CT',
        confidence: 98.6,
        status: 'Normal',
        findings: {
          'nodulesFound': 0,
          'suspiciousAreas': 0,
          'lungVolume': 5.2,
          'airwayHealth': 'Optimal',
        },
        nodules: [],
        biomarkers: BiomarkerData(
          breathVOC: -0.4,
          respiratoryRate: 16.0,
          bloodOxygen: 98.0,
          exhaledTemp: 33.2,
          hsCRP: 1.2,
          vocHistory: [0.3, 0.2, 0.25, 0.15, 0.12],
          respiratoryHistory: [0.1, 0.15, 0.2, 0.18, 0.16],
          oxygenHistory: [0.9, 0.92, 0.95, 0.94, 0.96],
          tempHistory: [0.25, 0.28, 0.22, 0.24, 0.27],
        ),
        reportUrl: 'https://lungguard.ai/reports/scan_001',
      ),
      ScanResult(
        id: 'scan_002',
        scanDate: DateTime.now().subtract(const Duration(days: 95)),
        scanType: 'CT Fusion',
        confidence: 97.8,
        status: 'Normal',
        findings: {
          'nodulesFound': 0,
          'suspiciousAreas': 0,
          'lungVolume': 5.1,
          'airwayHealth': 'Optimal',
        },
        nodules: [],
        biomarkers: BiomarkerData(
          breathVOC: -0.2,
          respiratoryRate: 16.5,
          bloodOxygen: 97.5,
          exhaledTemp: 33.5,
          hsCRP: 1.5,
          vocHistory: [0.35, 0.25, 0.3, 0.2, 0.22],
          respiratoryHistory: [0.12, 0.18, 0.22, 0.2, 0.19],
          oxygenHistory: [0.88, 0.9, 0.93, 0.92, 0.94],
          tempHistory: [0.28, 0.3, 0.25, 0.27, 0.29],
        ),
        reportUrl: 'https://lungguard.ai/reports/scan_002',
      ),
      ScanResult(
        id: 'scan_003',
        scanDate: DateTime.now().subtract(const Duration(days: 185)),
        scanType: 'PET-CT',
        confidence: 96.4,
        status: 'Normal',
        findings: {
          'nodulesFound': 1,
          'suspiciousAreas': 0,
          'lungVolume': 5.0,
          'airwayHealth': 'Good',
        },
        nodules: [
          Nodule(
            id: 'nodule_001',
            location: 'Right upper lobe',
            size: 3.2,
            shape: 'Round',
            malignancyProbability: 2.1,
            recommendation: 'Stable, continue monitoring',
          ),
        ],
        biomarkers: BiomarkerData(
          breathVOC: 0.1,
          respiratoryRate: 17.0,
          bloodOxygen: 97.0,
          exhaledTemp: 33.8,
          hsCRP: 1.8,
          vocHistory: [0.4, 0.35, 0.38, 0.32, 0.3],
          respiratoryHistory: [0.15, 0.2, 0.24, 0.22, 0.21],
          oxygenHistory: [0.85, 0.88, 0.91, 0.9, 0.92],
          tempHistory: [0.3, 0.32, 0.28, 0.3, 0.31],
        ),
        reportUrl: 'https://lungguard.ai/reports/scan_003',
      ),
    ];
  }

  // Appointments
  List<Appointment> getUpcomingAppointments() {
    return [
      Appointment(
        id: 'appt_001',
        title: 'Preventive pulmonology',
        clinician: 'Dr. Mira Sethi',
        dateTime: DateTime(2024, 2, 12, 10, 0),
        location: 'Oncology Hybrid Lab',
        type: AppointmentType.preventive,
        accentColors: const [Color(0xFF7F7FD5), Color(0xFF86A8E7)],
      ),
      Appointment(
        id: 'appt_002',
        title: 'Breathomics coaching',
        clinician: 'Coach Liam',
        dateTime: DateTime(2024, 2, 15, 18, 30),
        location: 'Remote / XR session',
        type: AppointmentType.coaching,
        accentColors: const [Color(0xFF0BA360), Color(0xFF34A853)],
      ),
      Appointment(
        id: 'appt_003',
        title: 'Follow-up consultation',
        clinician: 'Dr. Mira Sethi',
        dateTime: DateTime(2024, 2, 20, 14, 30),
        location: 'Virtual consultation',
        type: AppointmentType.consultation,
        accentColors: const [Color(0xFF43CBFF), Color(0xFF9708CC)],
      ),
    ];
  }

  // Care Tasks
  List<CareTask> getCareTasks() {
    return [
      CareTask(
        id: 'task_001',
        title: 'Pranayama routine',
        subtitle: 'Morning breathing exercises',
        adherence: 92.0,
        completed: false,
        lastSynced: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      CareTask(
        id: 'task_002',
        title: 'Micro-nutrition log',
        subtitle: 'Track daily nutrition intake',
        adherence: 100.0,
        completed: true,
        lastSynced: DateTime.now(),
      ),
      CareTask(
        id: 'task_003',
        title: 'Sleep sync',
        subtitle: 'Wearable device synchronization',
        adherence: 88.0,
        completed: false,
        lastSynced: DateTime.now().subtract(const Duration(hours: 3)),
      ),
      CareTask(
        id: 'task_004',
        title: 'Meditation session',
        subtitle: 'Stress reduction practice',
        adherence: 75.0,
        completed: false,
        lastSynced: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }

  // Risk Insights
  List<Map<String, dynamic>> getRiskInsights() {
    return [
      {
        'label': 'Risk level',
        'value': 'Low (12%)',
        'detail': 'No nodular growth in last 6 months.',
        'icon': Icons.shield_moon_outlined,
      },
      {
        'label': 'Scan cadence',
        'value': 'Every 90 days',
        'detail': 'Adaptive schedule + clinician override.',
        'icon': Icons.calendar_month_outlined,
      },
      {
        'label': 'Biomarker trend',
        'value': 'Improving',
        'detail': 'VOC levels down 4.3% vs baseline.',
        'icon': Icons.trending_down_rounded,
      },
    ];
  }

  // Program Cards Data
  List<Map<String, dynamic>> getProgramCards() {
    return [
      {
        'title': 'High-Res CT Insight',
        'description': 'Volumetric overlays verified by oncology board.',
        'accuracy': 98.6,
        'gradient': const [Color(0xFF43CBFF), Color(0xFF9708CC)],
      },
      {
        'title': 'Breath Biomarker Lab',
        'description': 'Exhaled VOC nano-sensor analytics.',
        'accuracy': 94.2,
        'gradient': const [Color(0xFF6EE2F5), Color(0xFF6454F0)],
      },
      {
        'title': 'Preventive Coaching',
        'description': 'Digital twin forecasts & lifestyle nudges.',
        'accuracy': 91.8,
        'gradient': const [Color(0xFF0BA360), Color(0xFF3CBA92)],
      },
    ];
  }

  // Timeline Events
  List<Map<String, dynamic>> getTimelineEvents() {
    return [
      {
        'title': 'CT scan completed',
        'subtitle': 'High-res volumetric analysis',
        'time': '5 days ago',
        'icon': Icons.scanner_rounded,
      },
      {
        'title': 'Biomarker sync',
        'subtitle': 'Wearable mesh updated',
        'time': '1 week ago',
        'icon': Icons.sync_rounded,
      },
      {
        'title': 'Care plan adjusted',
        'subtitle': 'Dr. Sethi reviewed protocol',
        'time': '2 weeks ago',
        'icon': Icons.medical_services_rounded,
      },
      {
        'title': 'Lifestyle assessment',
        'subtitle': 'Digital twin recalibrated',
        'time': '3 weeks ago',
        'icon': Icons.psychology_rounded,
      },
    ];
  }

  // Insight History
  List<Map<String, dynamic>> getInsightHistory() {
    return [
      {
        'title': 'No malignant signature',
        'subtitle': 'CT fusion • Feb 03',
        'trend': '+0.2% accuracy vs last scan',
        'icon': Icons.check_circle_outline_rounded,
      },
      {
        'title': 'Inflammation decreasing',
        'subtitle': 'Biomarkers • Jan 28',
        'trend': '-4.3% hs-CRP vs baseline',
        'icon': Icons.trending_down_rounded,
      },
      {
        'title': 'Lifestyle uplift',
        'subtitle': 'Behavior twin • Jan 21',
        'trend': '+8% respiratory capacity',
        'icon': Icons.trending_up_rounded,
      },
      {
        'title': 'Nodule stability confirmed',
        'subtitle': 'Radiology review • Jan 15',
        'trend': 'No growth detected',
        'icon': Icons.verified_rounded,
      },
    ];
  }
}

