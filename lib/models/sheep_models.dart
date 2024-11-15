class Sheep {
  final String id;
  final String sheepName;
  final String sheepBirth;
  final String sheepGender;
  final String? sheepPhoto;

  Sheep({
    required this.id,
    required this.sheepName,
    required this.sheepBirth,
    required this.sheepGender,
    this.sheepPhoto,
  });

  factory Sheep.fromJson(Map<String, dynamic> json) {
    return Sheep(
      id: json['id'],
      sheepName: json['sheep_name'],
      sheepBirth: json['sheep_birth'],
      sheepGender: json['sheep_gender'],
      sheepPhoto: json['sheep_photo'],
    );
  }
}
