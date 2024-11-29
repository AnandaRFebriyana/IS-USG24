import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobileapp/models/radiologi_models.dart';
import 'package:mobileapp/models/vital_sign_models.dart';
import 'package:mobileapp/services/constans.dart';

class RadiologiService {

  static Future<List<Radiologi>> getRadiologi() async {
    String? token = await Constant.getToken();
    final url = Uri.parse(Constant.GET_VITAL);
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      List<Radiologi> radiologiList = (result['data'] as List)
          .map((data) => Radiologi.fromJson(data))
          .toList();
      return radiologiList;
    } else {
      throw Exception('Failed to load vital signs data. Status code: ${response.statusCode}');
    }
  }
}
