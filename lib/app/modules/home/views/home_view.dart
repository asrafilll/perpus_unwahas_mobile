import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perpus_unwahas_mobile/app/modules/category/views/category_view.dart';
import 'package:perpus_unwahas_mobile/app/modules/home/views/home_page_componenet.dart';
import 'package:perpus_unwahas_mobile/app/modules/setting/views/setting_view.dart';
import 'package:perpus_unwahas_mobile/utils/app_colors.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (homeController.tabIndex.value) {
          case 0:
            return HomePageComponent(books: homeController.books);
          case 1:
            return const CategoryView();
          case 2:
            return const SettingView();
          default:
            return HomePageComponent(books: homeController.books);
        }
      }),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: const Color(0XFF9B9B9B),
            showUnselectedLabels: true,
            currentIndex: homeController.tabIndex.value,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              homeController.changeTabIndex(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Category'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Setting'),
            ],
          )),
    );
  }
}
