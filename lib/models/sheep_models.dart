class Sheep {
  final String idDomba;
  final String namaDomba;
  final String tanggalLahir;
  final String jenisDomba;
  final String image;

  Sheep({
    required this.idDomba,
    required this.namaDomba,
    required this.tanggalLahir,
    required this.jenisDomba,
    required this.image,
  });

  factory Sheep.fromJson(Map<String, dynamic> json) {
    return Sheep(
      idDomba: json['id'],
      namaDomba: json['sheep_name'],
      tanggalLahir: json['sheep_birth'],
      jenisDomba: json['sheep_gender'],
      image: json['sheep_photo'], // Assuming a placeholder image for now
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': idDomba,
      'sheep_name': namaDomba,
      'sheep_birth': tanggalLahir,
      'sheep_gender' : jenisDomba,
      'sheep_photo' : image,
    };
  }
}
