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
        Uri.parse(Constant.GET_ASESSMENT),
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

  // Method untuk mengambil assessment berdasarkan ID
  Future<Assessment?> getAssessmentById(String id) async {
    try {
      final token = await Constant.getToken();
      final response = await http.get(
        Uri.parse(Constant.GET_ASESSMENTBYID.replaceFirst("{id}", id)),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return Assessment.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load assessment');
      }
    } catch (e) {
      throw Exception('Failed to fetch assessment by ID: $e');
    }
  }
}
