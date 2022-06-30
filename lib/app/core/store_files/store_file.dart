import 'dart:io';

import 'package:path_provider/path_provider.dart';

class StoreFile {
  static Future<File> storeFile(List<int> bytes) async {
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/exemplo.pdf');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}
