import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobileapp/models/sheep_models.dart';
import 'package:mobileapp/constans.dart';

class SheepService {
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

  static Future<Sheep> fetchSheepById(String id) async {
    final url = Uri.parse(Constant.GET_SHEEPBYID);
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${await Constant.getToken()}'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return Sheep.fromJson(jsonResponse['data']);
    } else if (response.statusCode == 404) {
      throw Exception('Domba dengan ID $id tidak ditemukan');
    } else {
      throw Exception('Gagal memuat data: ${response.statusCode}');
    }
  }

  static Future<void> postSheep(Sheep sheep) async {
    try {
      String? token = await Constant.getToken();
      final url = Uri.parse(Constant.POST_SHEEP);
      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      request.fields['sheep_name'] = sheep.sheepName;
      request.fields['sheep_birth'] = sheep.sheepBirth.toString();
      request.fields['sheep_gender'] = sheep.sheepGender;
      if (sheep.sheepPhoto != null) {
        request.files.add(
          await http.MultipartFile.fromPath('sheep_photo', sheep.sheepPhoto!.path),
        );
      }
      final response = await request.send();

      if (response.statusCode == 201) {
        print('Successfully create sheep data.');
      } else {
        String errorMessage = await response.stream.bytesToString();
        throw 'Failed to create report: $errorMessage';
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}