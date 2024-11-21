import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobileapp/models/vital_sign_models.dart';
import 'package:mobileapp/services/constans.dart';

class VitalSignsService {

  static Future<List<VitalSigns>> getVitalSigns() async {
    String? token = await Constant.getToken();
    final url = Uri.parse(Constant.GET_VITAL);
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      List<VitalSigns> vitalSignsList = (result['data'] as List)
          .map((data) => VitalSigns.fromJson(data))
          .toList();
      return vitalSignsList;
    } else {
      throw Exception('Failed to load vital signs data. Status code: ${response.statusCode}');
    }
  }
}
