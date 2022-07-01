import 'package:flutter_job_timer_dw/app/core/adapters/json_to_project.dart';
import 'package:flutter_job_timer_dw/app/core/adapters/json_to_task.dart';
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
  Future<void> register(ProjectEntity project) async {
    final projectMap = JsonToProject.toMap(project);
    await _projectRepository.register(projectMap);
  }

  @override
  Future<List<ProjectEntity>> findByStatus(ProjectStatus status) async {
    final projectsMap = await _projectRepository.findByStatus(status.index);

    return projectsMap.map((proj) => JsonToProject.fromMap(proj)).toList();
    // return projects
    //     .map((e) => e.map((map) => ProjectModel.fromMap(map)).toList())
    //     .first;
  }

  @override
  Future<void> addTask(String projectId, ProjectTask task) async {
    final taskMap = JsonToTask.toMap(task);
    await _projectRepository.addTask(projectId, taskMap);
  }

  @override
  Future<void> finish(String projectId) async {
    await _projectRepository.finish(projectId);
  }

  @override
  Future<ProjectEntity> findById(String projectId) async {
    final projectEntity = await _projectRepository.findById(projectId);
    final project = JsonToProject.fromMap(projectEntity);
    return project;
  }

  @override
  Future<File> getPdfFile(String url) async {
    return await _projectRepository.getFilePathByUrl(url);
  }
}
