// splash_controller.dart
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perpus_unwahas_mobile/app/routes/app_pages.dart';

class SplashController extends GetxController {
  final GetStorage box = GetStorage();

  @override
  void onInit() {
    checkData();
    super.onInit();
  }

  void checkData() {
    Future.delayed(const Duration(seconds: 2), () {
      if (box.hasData('studentData')) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    });
  }
}
