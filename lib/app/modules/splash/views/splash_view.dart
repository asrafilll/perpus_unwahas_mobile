import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perpus_unwahas_mobile/utils/app_assets.dart';
import 'package:perpus_unwahas_mobile/utils/app_text_styles.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  SplashView({super.key});

  @override
  final SplashController controller = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.primaryLogo),
            const SizedBox(height: 8),
            Text(
              'Fakultas Ekonomi &\nManajemen Unwahas'.toUpperCase(),
              textAlign: TextAlign.center,
              style: AppTextStyles.primaryTextStyle.copyWith(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
