import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class PDFViewerPage extends StatelessWidget {
  final String fileUrl;
  final String userId;

  const PDFViewerPage({super.key, required this.fileUrl, required this.userId});

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        title: const Text('Invoice'),
      ),
      path: '$userId/invoices/$fileUrl',
    );
  }
}
