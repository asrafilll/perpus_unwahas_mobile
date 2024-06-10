import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:perpus_unwahas_mobile/utils/app_constans.dart';

class RegisterController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nimController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> registerStudent() async {
    final String name = nameController.text;
    final String nim = nimController.text;
    final String password = passwordController.text;

    if (name.isEmpty || nim.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    const url = '${AppConstants.baseURL}${APIURL.register}';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'fullName': name,
        'NIM': nim,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    isLoading.value = false;

    if (response.statusCode == 201) {
      // Handle successful registration
      Get.snackbar(
        'Success',
        'Registration successful',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.toNamed('/login');
    } else {
      // Handle registration error
      Get.snackbar(
        'Error',
        'Registration failed',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
