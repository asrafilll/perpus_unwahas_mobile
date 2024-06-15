import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perpus_unwahas_mobile/utils/app_constans.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginController extends GetxController {
  final TextEditingController nimController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isLoading = false.obs;

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

    print(response.body);
    print(response.statusCode);
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
}
