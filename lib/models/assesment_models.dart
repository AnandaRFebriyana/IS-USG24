class Assessment {
  final String id;
  final String sheepId;
  final String userId;
  final String hoof;
  final String eye;
  final String wool;
  final String? additionalInfo;
  final DateTime created_at;

  Assessment({
    required this.id,
    required this.sheepId,
    required this.userId,
    required this.hoof,
    required this.eye,
    required this.wool,
    this.additionalInfo,
    required this.created_at,
  });

  // Factory method to create an Assessment from JSON data
  factory Assessment.fromJson(Map<String, dynamic> json) {
    return Assessment(
      id: json['id'].toString(),  // Convert to String if needed
      sheepId: json['sheep_id'] as String,
      userId: json['user_id'].toString(),
      hoof: json['hoof'] as String,
      eye: json['eye'] as String,
      wool: json['wool'] as String,
      additionalInfo: json['additional_info'],
      created_at: DateTime.parse(json['created_at']),
    );
  }

  // // Method to convert Assessment to JSON (if needed for POST requests)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sheep_id': sheepId,
      'user_id': userId,
      'hoof': hoof,
      'eye': eye,
      'wool': wool,
      'additional_info': additionalInfo,
      'created_at' : created_at,
    };
  }
}
