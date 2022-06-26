import 'package:flutter_job_timer_dw/app/core/database/database.dart';
import 'package:flutter_job_timer_dw/app/core/exceptions/failure.dart';
import 'package:flutter_job_timer_dw/app/entities/project.dart';
import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
import 'package:flutter_job_timer_dw/app/entities/project_task.dart';
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

  @override
  Future<List<Project>> findByStatus(ProjectStatus status) async {
    try {
      final connection = await _database.openConnetion();
      final projects =
          await connection.projects.filter().statusEqualTo(status).findAll();
      return projects;
    } on IsarError {
      throw Failure(message: 'Erro ao buscar projetos');
    }
  }

  @override
  Future<void> addTask(int projectId, ProjectTask taskEntity) async {
    try {
      final connection = await _database.openConnetion();
      final project =
          await connection.projects.filter().idEqualTo(projectId).findFirst();

      if (project == null) {
        throw Failure(message: 'Projeto não encontrado');
      }

      project.tasks.add(taskEntity);
      await connection.writeTxn((isar) => project.tasks.save());
      // return projects;
    } on IsarError {
      throw Failure(message: 'Erro ao buscar projetos');
    }
  }
}
