import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perpus_unwahas_mobile/utils/app_constans.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginController extends GetxController {
  final TextEditingController nimController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final RxBool isObscured = true.obs;

  RxBool isLoading = false.obs;

  void seePassword() {
    isObscured.value = !isObscured.value;
    update();
  }

  Future<void> loginStudent() async {
    final String nim = nimController.text;
    final String password = passwordController.text;

    if (nim.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    const url = '${AppConstants.baseURL}${APIURL.login}';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'NIM': nim,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    isLoading.value = false;
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      final box = GetStorage();
      await box.write('studentData', responseData);

      Get.snackbar(
        'Success',
        'Login successful',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offNamed('/home');
    } else {
      // Handle login error
      Get.snackbar(
        'Error',
        'Login failed',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> updatePassword() async {
    final String nim = nimController.text;
    final String newPassword = newPasswordController.text;
    final String confirmPassword = confirmPasswordController.text;

    if (nim.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
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
        'NIM': nim,
        'new_password': newPassword,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    isLoading.value = false;
    if (response.statusCode == 200) {
      Get.snackbar(
        'Success',
        'Password reset successful',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offNamed('/login'); // Navigate back to login page
    } else {
      // Handle password reset error
      Get.snackbar(
        'Error',
        'Password reset failed',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
