import 'package:shared_preferences/shared_preferences.dart';

class Constant {
  static const String BASE_URL_LOCAL = 'http://127.0.0.1:8000/api';
  static const String BASE_URL = 'https://isusg-mbkm.research-ai.my.id/api';

  static const String LOGIN = '$BASE_URL/login';
  static const String LOGOUT = '$BASE_URL/logout';
  static const String GET_USER = '$BASE_URL/get-user';
  static const String GET_SHEEP = '$BASE_URL/sheep';
  static const String POST_SHEEP = '$BASE_URL/sheep/store';
  static const String GET_ASSESSMENT = '$BASE_URL/assessment';
  static const String GET_VITAL = '$BASE_URL/vital';
  static const String GET_RADIOLOGY = '$BASE_URL/radiology';

  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}