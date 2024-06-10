import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perpus_unwahas_mobile/components/primary_button.dart';
import 'package:perpus_unwahas_mobile/utils/app_assets.dart';
import 'package:perpus_unwahas_mobile/utils/app_text_styles.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 48),
                const Text(
                  'Login Library',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Image.asset(
                  AppAssets.primaryLogo,
                  width: 80,
                ),
                const SizedBox(height: 24),
                Text(
                  'Perpustakaan Digital\nManajemen Unwahas'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.titleTextStyle.copyWith(fontSize: 18),
                ),
                Text(
                  'Fakultas Ekonomi & Manajemen Unwahas'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.titleTextStyle.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller.nimController,
                  decoration: const InputDecoration(
                      labelText: 'Nomor Induk Mahasiswa (NIM)'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                const SizedBox(height: 20),
                Obx(() => PrimaryButton(
                      onTap: controller.isLoading.value
                          ? null
                          : () {
                              controller.loginStudent();
                            },
                      textButton:
                          controller.isLoading.value ? 'Loading...' : 'Login',
                    )),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/register');
                  },
                  child: const Text(
                    'Belum punya akun? Daftar',
                    style: TextStyle(
                      color: Color.fromARGB(255, 143, 143, 143),
                    ),
                  ),
                ),
                Image.asset(AppAssets.poweredBy),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
