import 'package:shared_preferences/shared_preferences.dart';

class Constant {
  // static const String BASE_URL = '';
  //static const String BASE_URL = 'https://isusg-mbkm.research-ai.my.id/api/';

  static const String LOGIN_URL = 'https://isusg-mbkm.research-ai.my.id/api/login';
  static const String LOGOUT_URL = 'https://isusg-mbkm.research-ai.my.id/api/logout';
  static const String GET_USER_URL = 'https://isusg-mbkm.research-ai.my.id/api/get-user';

  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}  