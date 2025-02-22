import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perpus_unwahas_mobile/app/modules/login/views/forgot_passowrd_view.dart';
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
                  AppAssets.manajemenLogo,
                  width: 160,
                ),
                const SizedBox(height: 24),
                Text(
                  'Perpustakaan Digital\nProdi Manajemen'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.titleTextStyle.copyWith(fontSize: 18),
                ),
                Text(
                  'FAKULTAS EKONOMI & BISNIS UNWAHAS'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller.nimController,
                  decoration: const InputDecoration(
                      labelText: 'Nomor Induk Mahasiswa (NIM)'),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => TextField(
                    controller: controller.passwordController,
                    obscureText: controller.isObscured.value,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                          icon: Icon(
                            controller.isObscured.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () => {controller.seePassword()}),
                    ),
                  ),
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
                Column(
                  children: [
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
                    TextButton(
                      onPressed: () {
                        Get.to(() => const ForgotPasswordView());
                      },
                      child: const Text(
                        'Lupa password? Reset Password',
                        style: TextStyle(
                          color: Color.fromARGB(255, 143, 143, 143),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Image.asset(AppAssets.poweredBy),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
