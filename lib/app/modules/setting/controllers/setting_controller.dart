import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perpus_unwahas_mobile/utils/app_constans.dart';
import 'package:http/http.dart' as http;

class SettingController extends GetxController {
  final box = GetStorage();
  RxMap<dynamic, dynamic> studentData = {}.obs;
  final TextEditingController nimController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final RxBool isObscured = true.obs;
  RxBool isLoading = false.obs;

  void seePassword() {
    isObscured.value = !isObscured.value;
    update();
  }

  @override
  void onInit() {
    loadStudentData();
    super.onInit();
  }

  Future<void> loadStudentData() async {
    studentData.value = await box.read('studentData');
    update();
  }

  Future<void> logoutStudent() async {
    await box.remove('studentData');

    Get.snackbar(
      'Success',
      'Logout successful',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    Get.offNamed('/splash');
  }

  Future<void> updatePassword() async {
    final String newPassword = newPasswordController.text;
    final String confirmPassword = confirmPasswordController.text;

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (newPassword != confirmPassword) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    const url = '${AppConstants.baseURL}${APIURL.updatePassword}';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'NIM': studentData['user']['NIM'],
        'new_password': newPassword,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print(url);
    print(response.body);
    print(studentData['user']['NIM']);

    isLoading.value = false;
    if (response.statusCode == 200) {
      Get.snackbar(
        'Success',
        'Password change successful',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offNamed('/setting'); // Navigate back to login page
    } else {
      // Handle password change error
      Get.snackbar(
        'Error',
        'Password change failed',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
