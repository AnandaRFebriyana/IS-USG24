class Assessment {
  final String id;
  final String sheepId;
  final String userId;
  final String symptom1;
  final String symptom2;
  final String symptom3;
  final String additionalInfo;

  Assessment({
    required this.id,
    required this.sheepId,
    required this.userId,
    required this.symptom1,
    required this.symptom2,
    required this.symptom3,
    required this.additionalInfo,
  });

  // Factory method to create an Assessment from JSON data
  factory Assessment.fromJson(Map<String, dynamic> json) {
    return Assessment(
      id: json['id'].toString(),  // Convert to String if needed
      sheepId: json['sheep_id'] as String,
      userId: json['user_id'].toString(),
      symptom1: json['symptom_1'] as String,
      symptom2: json['symptom_2'] as String,
      symptom3: json['symptom_3'] as String,
      additionalInfo: json['additional_info'] as String? ?? '',
    );
  }

  // // Method to convert Assessment to JSON (if needed for POST requests)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sheep_id': sheepId,
      'user_id': userId,
      'symptom_1': symptom1,
      'symptom_2': symptom2,
      'symptom_3': symptom3,
      'additional_info': additionalInfo,
    };
  }
}
