import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class StoragePage extends StatefulWidget {
  const StoragePage({Key? key}) : super(key: key);

  @override
  State<StoragePage> createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> {
  final FirebaseStorage storage = FirebaseStorage.instance;

  List<Reference> refs = [];
  List<String> arquivos = [];
  bool loading = false;
  late final File pdf;

  // loadImages() async {
  //   try {
  //     loading = true;
  //     refs = (await storage.ref().listAll()).items;

  //     final data = await refs.first.getData();

  //     setState(() {
  //       pdf = File.fromRawPath(data!);

  //       // arquivos.add(refArq);
  //     });
  //     // for (var ref in refs) {}
  //     print(pdf);
  //   } catch (e) {
  //     AsukaSnackbar.alert(e.toString()).show();
  //   }
  // }

  Future<File> loadFirebase(String url) async {
    try {
      final refPDF = FirebaseStorage.instance.ref().child(url);
      final data = await refPDF.getData();

      // final bytes = File.fromRawPath(data!);

      return _storeFile(data!.toList());
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  Future<File> _storeFile(List<int> bytes) async {
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/exemplo.pdf');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Storage'),
      ),
      body: ElevatedButton(
        onPressed: () async {
          final pdfFile =
              await loadFirebase('Diagrama_Eletrico_Geral_Monza_Monzeiros.pdf');

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
