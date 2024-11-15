import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobileapp/models/user_models.dart';
import 'package:mobileapp/services/constans.dart';

class AuthService {
  static Future<User?> login(String email, String password) async {
    final url = Uri.parse(Constant.LOGIN);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return User.fromJson(result);
    } else {
      final errorResult = jsonDecode(response.body);
      throw '${errorResult['error'] ?? 'Unknown error occurred'}';
    }
  }

  static Future<void> logout() async {
    final url = Uri.parse(Constant.LOGOUT);
    String? token = await Constant.getToken();
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$token',
      },
    );

    if (response.statusCode == 200) {
      print('Successfully logged out');
    } else {
      print('Failed logout: ${response.reasonPhrase}');
    }
  }

  static Future<User> getUser() async {
    String? token = await Constant.getToken();
    final url = Uri.parse(Constant.GET_USER);
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return User.fromJson(result);
    } else {
      throw Exception('Failed to load user data');
    }
  }
}
