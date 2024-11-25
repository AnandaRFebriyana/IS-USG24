import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobileapp/models/assesment_models.dart';
import 'package:mobileapp/services/constans.dart';

class AssessmentService {
  // Method untuk mengambil semua data assessment
  Future<List<Assessment>> getAssessments() async {
    String? token = await Constant.getToken();
    final url = Uri.parse(Constant.GET_ASSESSMENT);
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
     if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      List<Assessment> vitalSignsList = (result['data'] as List)
          .map((data) => Assessment.fromJson(data))
          .toList();
      return vitalSignsList;
    } else {
      throw Exception('Failed to load vital signs data. Status code: ${response.statusCode}');
    }
  }
}
