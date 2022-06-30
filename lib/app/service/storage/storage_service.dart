import 'dart:io';

abstract class StorageService {
  Future<File> getPdfFile(String url);
}
