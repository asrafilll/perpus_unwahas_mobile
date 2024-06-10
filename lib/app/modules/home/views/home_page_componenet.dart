import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:perpus_unwahas_mobile/app/modules/home/controllers/BookModel.dart';
import 'package:perpus_unwahas_mobile/app/modules/home/views/pdf_viewer_page.dart';
import 'package:perpus_unwahas_mobile/utils/app_colors.dart';
import 'package:perpus_unwahas_mobile/utils/app_constans.dart';

class HomePageComponent extends StatelessWidget {
  final List<BookModel> books;

  const HomePageComponent({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.2,
            color: AppColors.primaryColor,
            padding: const EdgeInsets.only(left: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                Text(
                  'Perpustakaan Digital\nManajemen Unwahas'.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  'Fakultas Ekonomi dan Manajemen Unwahas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return _buildBookCard(
                    context,
                    book.cover,
                    book.title,
                    'Penulis: ${book.teachers}',
                    'Kategori: ${book.category.name}',
                    'Bahasa: Indonesia',
                    book.url,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookCard(BuildContext context, String imageUrl, String title,
      String author, String category, String language, String url) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              '${AppConstants.imgURL}$imageUrl',
              width: 100,
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(author),
                  Text(category),
                  Text(language),
                  const SizedBox(height: 16.0),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _openBookInApp(context, url);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text(
                          'Baca Sekarang',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      OutlinedButton(
                        onPressed: () {
                          _downloadPDF(context, url);
                        },
                        child: const Text('Download Buku'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _openBookInApp(BuildContext context, String bookUrl) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PDFViewerPage(bookUrl: bookUrl),
    ),
  );
}

void _downloadPDF(BuildContext context, String bookUrl) async {
  final dio = Dio();
  final directory = await getApplicationDocumentsDirectory();
  final fileName = bookUrl.split('/').last;
  final filePath = '${directory.path}/$fileName';

  try {
    final response = await dio.download(bookUrl, filePath);
    if (response.statusCode == 200) {
      // PDF downloaded successfully
      // Show a success message or perform any other actions
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PDF downloaded successfully')),
      );
    } else {
      // PDF download failed
      // Show an error message or handle the failure scenario
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PDF download failed')),
      );
    }
  } catch (e) {
    // Handle any errors that occur during the download
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error downloading PDF: $e')),
    );
  }
}
