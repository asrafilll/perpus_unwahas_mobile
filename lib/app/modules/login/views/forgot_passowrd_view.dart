import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perpus_unwahas_mobile/app/modules/login/controllers/login_controller.dart';
import 'package:perpus_unwahas_mobile/components/primary_button.dart';
import 'package:perpus_unwahas_mobile/utils/app_assets.dart';
import 'package:perpus_unwahas_mobile/utils/app_text_styles.dart';

class ForgotPasswordView extends GetView<LoginController> {
  const ForgotPasswordView({super.key});

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
                  'Reset Password',
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
                    controller: controller.newPasswordController,
                    obscureText: controller.isObscured.value,
                    decoration: InputDecoration(
                      labelText: 'New Password',
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
                const SizedBox(height: 10),
                Obx(
                  () => TextField(
                    controller: controller.confirmPasswordController,
                    obscureText: controller.isObscured.value,
                    decoration: InputDecoration(
                      labelText: 'Confirm New Password',
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
                              controller.updatePassword();
                            },
                      textButton: controller.isLoading.value
                          ? 'Loading...'
                          : 'Reset Password',
                    )),
                TextButton(
                  onPressed: () {
                    Get.back(); // Go back to login page
                  },
                  child: const Text(
                    'Back to Login',
                    style: TextStyle(
                      color: Color.fromARGB(255, 143, 143, 143),
                    ),
                  ),
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
