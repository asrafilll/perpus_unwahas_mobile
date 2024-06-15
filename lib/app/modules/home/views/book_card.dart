import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:perpus_unwahas_mobile/app/modules/home/views/pdf_read_page.dart';
import 'package:perpus_unwahas_mobile/app/modules/home/views/pdf_viewer_page.dart';
import 'package:perpus_unwahas_mobile/utils/app_constans.dart';
import 'package:perpus_unwahas_mobile/utils/download_link.dart';

class BookCard extends StatefulWidget {
  final BuildContext context;
  final String imageUrl;
  final String title;
  final String author;
  final String category;
  final String year;
  final String url;

  const BookCard({
    super.key,
    required this.context,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.category,
    required this.year,
    required this.url,
  });

  @override
  _BookCardState createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  bool isDownloading = false;

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

  void _downloadPDF(BuildContext context, String bookUrl, String title) async {
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

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              '${AppConstants.imgURL}${widget.imageUrl}',
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
                    widget.title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(widget.author),
                  Text('Kategori: ${widget.category}'),
                  Text('Tahun: ${widget.year}'),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _openBookInApp(context, widget.url, widget.title);
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
                                _downloadPDF(context, widget.url, widget.title);
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
}
