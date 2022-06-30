import 'dart:io';

abstract class StorageRepository {
  Future<File> getFileByUrl(String url);
}
