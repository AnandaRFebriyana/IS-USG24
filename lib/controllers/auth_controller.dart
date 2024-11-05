import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobileapp/components/alert_quick.dart';
import 'package:mobileapp/models/user_models.dart';
import 'package:mobileapp/services/auth_service.dart';
import 'package:mobileapp/services/constans.dart';

class AuthController {

  static Future<void> login(BuildContext context, TextEditingController email, TextEditingController password) async {
    try {
      User? user = await AuthService.login(email.text, password.text);
      if (user != null && user.token != null) {
        await Constant.saveToken(user.token!);
        Get.toNamed('/menu-nav', arguments: user);
      } else {
      print("Login failed: User token is null");
      MyQuickAlert.error(context, "Login failed: No token received");
    }
  } catch (error) {
    print("Login error: ${error.toString()}");
    MyQuickAlert.error(context, error.toString());
  }
}

  static Future<void> logout(BuildContext context) async {
    try {
      MyQuickAlert.confirm(
        context,
        'Do you want to logout',
        onConfirmBtnTap: () async {
          await AuthService.logout();
          Get.offAllNamed('/login');
        },
        onCancelBtnTap: () {
          Navigator.of(context).pop();
        },
      );
    } catch (error) {
      print(error.toString());
      MyQuickAlert.error(context, error.toString());
    }
  }
}