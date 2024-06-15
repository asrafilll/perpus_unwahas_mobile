import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:perpus_unwahas_mobile/app/modules/home/controllers/BookModel.dart';
import 'package:perpus_unwahas_mobile/utils/app_constans.dart';

class CategoryController extends GetxController {
  final RxList<dynamic> categories = <dynamic>[].obs;
  final RxBool isLoading = false.obs;
  var books = <BookModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http
          .get(Uri.parse('${AppConstants.baseURL}${APIURL.getAllCategories}'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        categories.value = data;
      } else {
        print('Failed to fetch categories: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  Future<void> fetchBooksByCategory(String query) async {
    try {
      isLoading.value = true;
      final response = await http
          .get(Uri.parse('${AppConstants.baseURL}${APIURL.filterBook(query)}'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        books.value =
            List<BookModel>.from(data.map((x) => BookModel.fromJson(x)));
      } else {
        print('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching books: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchBooks(String query) async {
    try {
      isLoading.value = true;
      final response = await http.get(
          Uri.parse('${AppConstants.baseURL}${APIURL.searchBooks(query)}'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        books.value =
            List<BookModel>.from(data.map((x) => BookModel.fromJson(x)));
      } else {
        print('Failed to search books: ${response.statusCode}');
      }
    } catch (e) {
      print('Error searching books: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
