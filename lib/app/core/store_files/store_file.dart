import 'dart:io';

import 'package:path_provider/path_provider.dart';

class StoreFile {
  static Future<File> storeFile(
      {required String name, required List<int> bytes}) async {
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}
