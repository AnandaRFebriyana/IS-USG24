import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapp/components/alert_quick.dart';
import 'package:mobileapp/models/sheep_models.dart';
import 'package:mobileapp/services/sheep_service.dart';

class SheepController {

  static Future<void> createSheep(BuildContext context, Sheep sheep) async {
    try {
      await SheepService.postSheep(sheep);
      MyQuickAlert.success(
        context,
        'Data Domba berhasil disimpan.!',
        onConfirmBtnTap: () {
          Navigator.of(context).pop();
          Get.toNamed('/menu-nav');
        },
      );
    } catch (e) {
      print('Error $e');
    }
  }
}