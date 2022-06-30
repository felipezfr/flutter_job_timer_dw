import 'dart:io';

abstract class StorageRepository {
  Future<File> getPdfFile(String url);
}
