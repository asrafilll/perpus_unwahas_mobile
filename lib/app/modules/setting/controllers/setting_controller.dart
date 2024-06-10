import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingController extends GetxController {
  Future<void> logoutStudent() async {
    final box = GetStorage();
    await box.remove('studentData');

    // Handle successful logout
    Get.snackbar(
      'Success',
      'Logout successful',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    Get.offNamed('/splash');
  }
}
