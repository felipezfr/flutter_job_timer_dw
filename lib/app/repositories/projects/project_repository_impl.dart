// import 'dart:io';

// import 'package:flutter_job_timer_dw/app/core/database/database.dart';
// import 'package:flutter_job_timer_dw/app/core/exceptions/failure.dart';
// import 'package:flutter_job_timer_dw/app/entities/project.dart';
// import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
// import 'package:flutter_job_timer_dw/app/entities/project_task.dart';
// import 'package:flutter_job_timer_dw/app/repositories/storage/storage_repository.dart';
// import 'package:isar/isar.dart';

// import './project_repository.dart';

// class ProjectRepositoryImpl implements ProjectRepository {
//   final Database _database;
//   final StorageRepository _storage;

//   ProjectRepositoryImpl(
//       {required Database database, required StorageRepository storage})
//       : _database = database,
//         _storage = storage;

//   Future<void> resetDatabase() async {
//     final connection = await _database.openConnetion();
//     await connection.writeTxn((isar) {
//       return isar.projects.clear();
//     });
//   }

//   @override
//   Future<void> register(Project project) async {
//     try {
//       final connection = await _database.openConnetion();
//       await connection.writeTxn((isar) {
//         return isar.projects.put(project);
//       });
//     } on IsarError {
//       // log('Erro ao cadastrar novo projeto', error: e, stackTrace: s);
//       throw Failure(message: 'Erro ao cadastrar novo projeto');
//     }
//   }

//   @override
//   Future<List<Project>> findByStatus(ProjectStatus status) async {
//     try {
//       final connection = await _database.openConnetion();
//       final projects =
//           await connection.projects.filter().statusEqualTo(status).findAll();
//       return projects;
//     } on IsarError {
//       throw Failure(message: 'Erro ao buscar projetos');
//     }
//   }

//   @override
//   Future<Project> findById(int projectId) async {
//     final connection = await _database.openConnetion();
//     final project = await connection.projects.get(projectId);

//     if (project == null) {
//       throw Failure(message: 'Projeto não encontrado');
//     }
//     return project;
//   }

//   @override
//   Future<void> addTask(int projectId, ProjectTask taskEntity) async {
//     try {
//       final connection = await _database.openConnetion();
//       final project = await findById(projectId);

//       project.tasks.add(taskEntity);
//       await connection.writeTxn((isar) => project.tasks.save());
//     } on IsarError {
//       throw Failure(message: 'Erro ao salvar task');
//     }
//   }

//   @override
//   Future<void> finish(int projectId) async {
//     try {
//       final connection = await _database.openConnetion();
//       final project = await findById(projectId);

//       project.status = ProjectStatus.finalizado;

//       await connection.writeTxn(
//         (isar) => connection.projects.put(project, saveLinks: true),
//       );
//     } on IsarError {
//       throw Failure(message: 'Erro ao finalizar projeto');
//     }
//   }

//   @override
//   Future<File> getFileByUrl(String url) async {
//     return await _storage.getFileByUrl(url);
//   }
// }
