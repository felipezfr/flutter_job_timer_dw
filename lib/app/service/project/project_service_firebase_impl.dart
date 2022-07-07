import 'package:flutter_job_timer_dw/app/core/adapters/project_dto.dart';
import 'package:flutter_job_timer_dw/app/core/adapters/task_dto.dart';
import 'package:flutter_job_timer_dw/app/entities/project_entity.dart';
import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
import 'package:flutter_job_timer_dw/app/entities/project_task.dart';
import 'package:flutter_job_timer_dw/app/repositories/projects/project_repository.dart';
import 'dart:io';

import 'package:flutter_job_timer_dw/app/service/project/project_service.dart';

class ProjectServiceFirebaseImpl implements ProjectService {
  final ProjectRepository _projectRepository;

  ProjectServiceFirebaseImpl({required ProjectRepository projectRepository})
      : _projectRepository = projectRepository;

  @override
  Future<void> register(Project project) async {
    final projectMap = ProjectDTO.toMap(project);
    await _projectRepository.register(projectMap);
  }

  @override
  Future<List<Project>> findByStatus(ProjectStatus status) async {
    final projectsMap = await _projectRepository.findByStatus(status.index);

    return projectsMap.map((proj) => ProjectDTO.fromMap(proj)).toList();
  }

  @override
  Future<void> addTask(String projectId, ProjectTask task) async {
    final taskMap = TaskDTO.toMap(task);
    taskMap['id'] =
        taskMap['id'] ?? DateTime.now().microsecondsSinceEpoch.toString();
    await _projectRepository.addTask(projectId, taskMap);
  }

  @override
  Future<void> finish(String projectId) async {
    await _projectRepository.finish(projectId);
  }

  @override
  Future<Project> findById(String projectId) async {
    final projectEntity = await _projectRepository.findById(projectId);
    final project = ProjectDTO.fromMap(projectEntity);
    return project;
  }

  @override
  Future<File> getPdfFile(String url) async {
    return await _projectRepository.getFilePathByUrl(url);
  }

  @override
  Stream<List<Project>> findByStatusStream(ProjectStatus status) {
    final projectsStream = _projectRepository.findByStatusStream(status.index);

    return projectsStream.map(
      (event) => event
          .map(
            (e) => ProjectDTO.fromMap(e),
          )
          .toList(),
    );
    // return projectsStream
    //     .map((e) => e.map((map) => ProjectModel.fromMap(map)).toList())
    //     .first;
  }

  @override
  Stream<Project> findByIdStream(String projectId) {
    final projectStream = _projectRepository.findByIdStream(projectId);

    return projectStream.map((e) => ProjectDTO.fromMap(e));
  }
}
