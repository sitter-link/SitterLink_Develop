import 'package:flutter/material.dart';
import 'package:nanny_app/core/widgets/appbar/custom_app_bar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatelessWidget {
  final String link;
  final String label;
  const PdfViewerScreen({
    super.key,
    required this.link,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: label,
      ),
      body: SfPdfViewer.network(
        link,
      ),
    );
  }
}
