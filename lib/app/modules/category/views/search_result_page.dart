import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perpus_unwahas_mobile/app/modules/category/controllers/category_controller.dart';
import 'package:perpus_unwahas_mobile/app/modules/home/views/book_card.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage(
      {super.key, required this.query, required this.isFilter});

  final String query;
  final bool isFilter;

  @override
  Widget build(BuildContext context) {
    final CategoryController controller = Get.find();

    // Fetch books based on the search type (filter or search)
    if (isFilter) {
      controller.fetchBooksByCategory(query);
    } else {
      controller.searchBooks(query);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Pencarian'),
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.books.isEmpty) {
            return const Center(
              child: Text('No books found.'),
            );
          } else {
            return ListView.builder(
              itemCount: controller.books.length,
              itemBuilder: (context, index) {
                final book = controller.books[index];
                return BookCard(
                    context: context,
                    imageUrl: book.cover,
                    title: book.title,
                    author: book.teachers,
                    category: book.category.name,
                    year: book.year.toString(),
                    url: book.url);
              },
            );
          }
        },
      ),
    );
  }
}
