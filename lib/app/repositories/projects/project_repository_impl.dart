import 'dart:developer';
import 'dart:math';

import 'package:flutter_job_timer_dw/app/core/database/database.dart';
import 'package:flutter_job_timer_dw/app/core/exceptions/failure.dart';
import 'package:flutter_job_timer_dw/app/entities/project.dart';
import 'package:isar/isar.dart';

import './project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final Database _database;

  ProjectRepositoryImpl({
    required Database database,
  }) : _database = database;

  @override
  Future<void> register(Project project) async {
    try {
      final connection = await _database.openConnetion();
      await connection.writeTxn((isar) {
        return isar.projects.put(project);
      });
    } on IsarError {
      // log('Erro ao cadastrar novo projeto', error: e, stackTrace: s);
      throw Failure(message: 'Erro ao cadastrar novo projeto');
    }
  }
}
