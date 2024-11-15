import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobileapp/models/sheep_models.dart';
import 'package:mobileapp/services/constans.dart';

class SheepService {
  static const String apiUrl = 'https://isusg-mbkm.research-ai.my.id/sheep-api';

  static Future<List<Sheep>> getSheep() async {
    String? token = await Constant.getToken();
    final url = Uri.parse(Constant.GET_SHEEP);
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return (result['data'] as List)
          .map((data) => Sheep.fromJson(data))
          .toList();
    } else {
      throw 'Failed to load sheep data. Status code: ${response.statusCode}';
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