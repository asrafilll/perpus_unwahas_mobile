import 'package:get/get.dart';
import 'package:perpus_unwahas_mobile/app/modules/category/controllers/category_controller.dart';
import 'package:perpus_unwahas_mobile/app/modules/home/controllers/BookModel.dart';
import 'package:perpus_unwahas_mobile/app/modules/setting/controllers/setting_controller.dart';
import 'package:perpus_unwahas_mobile/utils/app_constans.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeController extends GetxController {
  var tabIndex = 0.obs;
  var books = <BookModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBooks();
  }

  void changeTabIndex(int index) {
    // Delete the current controller before switching tabs
    switch (tabIndex.value) {
      case 1:
        if (Get.isRegistered<CategoryController>()) {
          Get.delete<CategoryController>();
        }
        break;
      case 2:
        if (Get.isRegistered<SettingController>()) {
          Get.delete<SettingController>();
        }
        break;
    }

    tabIndex(index);

    switch (index) {
      case 0:
        Get.put(HomeController());
        break;
      case 1:
        Get.put(CategoryController());
        break;
      case 2:
        Get.put(SettingController());
        break;
    }
  }

  Future<void> fetchBooks() async {
    try {
      isLoading(true);
      final response = await http
          .get(Uri.parse('${AppConstants.baseURL}${APIURL.getAllBooks}'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        books.value = List<dynamic>.from(jsonData['data'])
            .map((book) => BookModel.fromJson(book))
            .toList();
      } else {
        print('Failed to fetch books. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching books: $e');
    } finally {
      isLoading(false);
    }
  }
}
