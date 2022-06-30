import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_job_timer_dw/app/repositories/storage/storage_repository_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class StoragePage extends StatefulWidget {
  const StoragePage({Key? key}) : super(key: key);

  @override
  State<StoragePage> createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Storage'),
      ),
      body: ElevatedButton(
        onPressed: () async {
          final pdfFile = await Modular.get<StorageRepositoryImpl>()
              .getFileByUrl('Diagrama_Eletrico_Geral_Monza_Monzeiros.pdf');

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PdfViewWidget(pdf: pdfFile),
            ),
          );
        },
        child: const Text("pdf"),
      ),
    );
  }
}

class PdfViewWidget extends StatelessWidget {
  final File pdf;
  const PdfViewWidget({
    Key? key,
    required this.pdf,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PDFView(
        filePath: pdf.path,
      ),
    );
  }
}
