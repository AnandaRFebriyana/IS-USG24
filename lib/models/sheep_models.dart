class Sheep {
  final String idDomba;
  final String namaDomba;
  final String tanggalLahir;
  final String umur;
  final String jenisDomba;
  final String image;

  Sheep({
    required this.idDomba,
    required this.namaDomba,
    required this.tanggalLahir,
    required this.umur,
    required this.jenisDomba,
    required this.image,
  });

  factory Sheep.fromJson(Map<String, dynamic> json) {
    return Sheep(
      idDomba: json['id_domba'],
      namaDomba: json['nama_domba'],
      tanggalLahir: json['tanggal_lahir'],
      umur: json['umur'],
      jenisDomba: json['jenis_domba'],
      image: 'assets/domba_1.jpg', // Assuming a placeholder image for now
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id_domba': idDomba,
      'nama_domba': namaDomba,
      'tanggal_lahir': tanggalLahir,
      'umur' : umur,
      'jenis_domba' : jenisDomba,
    };
  }
}
