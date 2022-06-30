import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_job_timer_dw/app/core/store_files/store_file.dart';

import './storage_repository.dart';

class StorageRepositoryImpl implements StorageRepository {
  final FirebaseStorage _firebaseStorage;

  StorageRepositoryImpl({required FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage;

  @override
  Future<File> getFileByUrl(String url) async {
    try {
      final refPDF = _firebaseStorage.ref().child(url);
      final data = await refPDF.getData();
      final file = await StoreFile.storeFile(name: url, bytes: data!.toList());

      return file;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
