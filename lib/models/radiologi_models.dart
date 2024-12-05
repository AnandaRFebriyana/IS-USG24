class Radiologi {
  final int id;
  final int assesmentId;
  final String sheepId;
  final String sheepName;
  final String sheepCreated;
  final String pregnancyStatus;
  final String? additionalInfo;
  final String? radiologiImage;

  Radiologi({
    required this.id,
    required this.assesmentId,
    required this.sheepId,
    required this.sheepName,
    required this.sheepCreated,
    required this.pregnancyStatus,
    this.additionalInfo,
    this.radiologiImage,
  });

  factory Radiologi.fromJson(Map<String, dynamic> json) {
    return Radiologi(
      id: json['id'] ?? 0,
      assesmentId: json['assessment_id'] ?? 0,
      sheepName: json['sheep_name'] ?? '',
      sheepId: json['sheep_id'] ?? '',
      sheepCreated: json['created_at'] ?? '',
      additionalInfo: json['additional_info'] ?? '',
      pregnancyStatus: json['pregnancy_status'] ?? '',
      radiologiImage: json['ultrasound_image'] ?? '',
    );
  }
}
