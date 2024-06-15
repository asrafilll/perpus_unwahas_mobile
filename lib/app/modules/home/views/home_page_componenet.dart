import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:perpus_unwahas_mobile/app/modules/home/controllers/BookModel.dart';
import 'package:perpus_unwahas_mobile/app/modules/home/views/book_card.dart';
import 'package:perpus_unwahas_mobile/app/modules/home/views/pdf_read_page.dart';
import 'package:perpus_unwahas_mobile/app/modules/home/views/pdf_viewer_page.dart';
import 'package:perpus_unwahas_mobile/utils/app_colors.dart';
import 'package:perpus_unwahas_mobile/utils/app_constans.dart';
import 'package:perpus_unwahas_mobile/utils/download_link.dart';

class HomePageComponent extends StatefulWidget {
  final List<BookModel> books;

  const HomePageComponent({super.key, required this.books});

  @override
  State<HomePageComponent> createState() => _HomePageComponentState();
}

class _HomePageComponentState extends State<HomePageComponent> {
  bool isDownloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 16),
            child: Text(
              'List Buku',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: widget.books.length,
                itemBuilder: (context, index) {
                  final book = widget.books[index];
                  return BookCard(
                      context: context,
                      imageUrl: book.cover,
                      title: book.title,
                      author: book.teachers,
                      category: book.category.name,
                      year: book.year.toString(),
                      url: book.url);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookCard(
      BuildContext context,
      String imageUrl,
      String title,
      String author,
      String category,
      String year,
      String url,
      bool isDownloading) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              '${AppConstants.imgURL}$imageUrl',
              width: 80,
              height: 140,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
            const SizedBox(width: 12.0),
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
                  const SizedBox(height: 4.0),
                  Text(author),
                  Text(category),
                  Text(year),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _openBookInApp(context, url, title);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text(
                          'Baca',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      OutlinedButton(
                        onPressed: isDownloading
                            ? null
                            : () {
                                _downloadPDF(context, url, title);
                              },
                        child: isDownloading
                            ? const Text('Downloading')
                            : const Text('Download'),
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

  void _downloadPDF(
    BuildContext context,
    String bookUrl,
    String title,
  ) async {
    setState(() {
      isDownloading = true;
    });

    final dio = Dio();
    final directory = await getApplicationDocumentsDirectory();
    final fileName = bookUrl.split('/').last;
    final filePath = '${directory.path}/$fileName';

    try {
      final directDownloadUrl = getDirectDownloadUrl(bookUrl);
      final response = await dio.download(directDownloadUrl, filePath);

      if (response.statusCode == 200) {
        // Use mounted check before showing the modal
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('PDF Downloaded'),
                content: Text('The PDF has been saved to:\n$filePath'),
                actions: [
                  TextButton(
                    child: const Text('Open PDF'),
                    onPressed: () {
                      Navigator.pop(context); // Close the modal
                      setState(() {
                        isDownloading = false;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PDFReadPage(filePath: filePath, title: title),
                        ),
                      );
                    },
                  ),
                  TextButton(
                    child: const Text('Close'),
                    onPressed: () {
                      Navigator.pop(context); // Close the modal
                      setState(() {
                        isDownloading = false;
                      });
                    },
                  ),
                ],
              );
            },
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('PDF download failed')),
        );
        setState(() {
          isDownloading = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error downloading PDF: $e')),
      );
      setState(() {
        isDownloading = false;
      });
    }
  }
}

void _openBookInApp(BuildContext context, String bookUrl, String title) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PDFViewerPage(
        bookUrl: bookUrl,
        title: title,
      ),
    ),
  );
}
