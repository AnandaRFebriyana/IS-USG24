import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobileapp/models/assesment_models.dart';
import 'package:mobileapp/services/constans.dart';

class AssessmentService {
  // Method untuk mengambil semua data assessment
  Future<List<Assessment>> getAssessments() async {
    try {
      final token = await Constant.getToken();
      final response = await http.get(
        Uri.parse(Constant.GET_ASSESSMENT),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => Assessment.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load assessments: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}
