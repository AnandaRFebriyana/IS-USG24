import 'dart:convert';

import '../models/sheep_models.dart';
import 'package:http/http.dart' as http;
import 'package:mobileapp/models/sheep_models.dart';

class SheepService {
  static const String apiUrl = 'https://isusg-mbkm.research-ai.my.id/sheep-api';

  Future<List<Sheep>> fetchSheep() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        return responseData.map((data) => Sheep.fromJson(data)).toList();
      } else {
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      // Tangani kesalahan jaringan atau kesalahan lainnya di sini
      print('Error fetching data: $e');
      throw Exception('Gagal memuat data');
    }
  }
   Future<Sheep> fetchSheepById(String id) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/$id'));
      if (response.statusCode == 200) {
        return Sheep.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Gagal memuat data');
    }
  }
}
// class SheepService {
//   // Data dummy
//   static final List<Sheep> dummySheepData = [
//     Sheep(
//       idDomba: 'D001',
//       namaDomba: 'Domba Garut',
//       tanggalLahir: '2024-04-01',
//       umur: '6 bulan',
//       jenisDomba: 'Induk',
//       image: 'assets/images/domba1.jpg',
//     ),
//     Sheep(
//       idDomba: 'D002',
//       namaDomba: 'Domba Merino',
//       tanggalLahir: '2021-06-15',
//       umur: '4',
//       jenisDomba: 'Anak',
//       image: 'assets/images/domba2.jpg',
//     ),
//     // Tambahkan lebih banyak data dummy sesuai kebutuhan
//   ];

//   // Fungsi untuk mendapatkan semua data domba (dummy)
//   Future<List<Sheep>> fetchSheep() async {
//     // Simulasikan penundaan untuk proses pemuatan data
//     await Future.delayed(Duration(seconds: 1));
//     return dummySheepData;
//   }

//   // Fungsi untuk mendapatkan data domba berdasarkan ID (dummy)
//   Future<Sheep> fetchSheepById(String idDomba) async {
//     await Future.delayed(Duration(seconds: 1));
//     return dummySheepData.firstWhere((sheep) => sheep.idDomba == idDomba);
//   }
// }
