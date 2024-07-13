import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perpus_unwahas_mobile/app/modules/setting/controllers/setting_controller.dart';
import 'package:perpus_unwahas_mobile/components/primary_button.dart';
import 'package:perpus_unwahas_mobile/utils/app_colors.dart';

class ChangePasswordView extends GetView<SettingController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Change Password',
        ),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                          : 'Change Password',
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
