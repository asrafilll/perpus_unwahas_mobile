import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perpus_unwahas_mobile/app/modules/category/views/search_result_page.dart';
import 'package:perpus_unwahas_mobile/utils/app_colors.dart';

import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kategori',
        ),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   width: double.infinity,
          //   height: MediaQuery.of(context).size.height * 0.2,
          //   color: AppColors.primaryColor,
          //   padding: const EdgeInsets.only(left: 24),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       const SizedBox(height: 8),
          //       Text(
          //         'Perpustakaan Digital\nManajemen Unwahas'.toUpperCase(),
          //         style: const TextStyle(
          //           color: Colors.white,
          //           fontWeight: FontWeight.bold,
          //           fontSize: 16,
          //         ),
          //       ),
          //       const Text(
          //         'Fakultas Ekonomi dan Manajemen Unwahas',
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 12,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: TextField(
              onSubmitted: (query) async {
                Get.to(() => SearchResultPage(
                      query: query,
                      isFilter: false,
                    ));
              },
              decoration: InputDecoration(
                hintText: 'Search categories',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 16),
            child: Text(
              'Cari berdasarkan kategori',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final category = controller.categories[index];

                  return InkWell(
                    onTap: () => Get.to(
                      () => SearchResultPage(
                        query: category['id'].toString(),
                        isFilter: true,
                      ),
                    ),
                    child: Container(
                      padding:
                          const EdgeInsets.only(right: 16, left: 16, bottom: 8),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Text(
                        category['name'],
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
