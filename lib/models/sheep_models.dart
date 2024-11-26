import 'dart:io';

class Sheep {
  final String id;
  final String sheepName;
  final DateTime sheepBirth;
  final String sheepGender;
  final File? sheepPhoto;

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
      sheepBirth: DateTime.parse(json['sheep_birth']),
      sheepGender: json['sheep_gender'],
      sheepPhoto: json['sheep_photo'] != null ? File(json['sheep_photo']) : null,
    );
  }
}
