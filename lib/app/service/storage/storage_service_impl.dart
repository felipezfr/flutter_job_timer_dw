import 'dart:io';

import 'package:flutter_job_timer_dw/app/repositories/storage/storage_repository.dart';

import './storage_service.dart';

class StorageServiceImpl implements StorageService {
  final StorageRepository _storageRepository;

  StorageServiceImpl({required StorageRepository storageRepository})
      : _storageRepository = storageRepository;

  @override
  Future<File> getPdfFile(String url) async {
    return await _storageRepository.getPdfFile(url);
  }
}
