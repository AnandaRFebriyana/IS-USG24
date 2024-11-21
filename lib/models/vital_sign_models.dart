class VitalSigns {
  final int id;
  final int assessmentId;
  final double temperature;
  final int heartRate;
  final int respiratoryRate;
  final double weight;
  final String? additionalInfo;
  final String statusCondition;
  final String sheepId;
  final String sheepName;
  final DateTime createdAt;

  VitalSigns({
    required this.id,
    required this.assessmentId,
    required this.temperature,
    required this.heartRate,
    required this.respiratoryRate,
    required this.weight,
    this.additionalInfo,
    required this.statusCondition,
    required this.sheepId,
    required this.sheepName,
    required this.createdAt,
  });

  factory VitalSigns.fromJson(Map<String, dynamic> json) {
    return VitalSigns(
      id: json['id'],
      assessmentId: json['assessment_id'],
      temperature: json['temperature'].toDouble(),
      heartRate: json['heart_rate'],
      respiratoryRate: json['respiratory_rate'],
      weight: json['weight'].toDouble(),
      additionalInfo: json['additional_info'],
      statusCondition: json['status_condition'],
      sheepId: json['sheep_id'],
      sheepName: json['sheep_name'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
