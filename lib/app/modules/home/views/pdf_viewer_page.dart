import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewerPage extends StatefulWidget {
  final String bookUrl;

  const PDFViewerPage({super.key, required this.bookUrl});

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  @override
  Widget build(BuildContext context) {
    final String directDownloadUrl = getDirectDownloadUrl(widget.bookUrl);
    print(directDownloadUrl);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: FutureBuilder<String>(
        future: Future.value(directDownloadUrl),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return PDFView(
                filePath: snapshot.data!,
                enableSwipe: true,
                swipeHorizontal: true,
                autoSpacing: false,
                pageFling: false,
                onRender: (pages) {
                  // No need for setState
                },
              );
            } else {
              return const Center(child: Text('Error loading PDF'));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

String getDirectDownloadUrl(String driveUrl) {
  final RegExp regex = RegExp(r'/d/(.+?)/');
  final String? fileId = regex.firstMatch(driveUrl)?.group(1);

  if (fileId != null) {
    return 'https://drive.google.com/uc?export=download&id=$fileId';
  } else {
    return driveUrl; // Return the original URL if file ID is not found
  }
}
