import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
import 'package:flutter_job_timer_dw/app/repositories/projects/project_repository_firebase.dart';
import 'dart:io';

import 'package:flutter_job_timer_dw/app/service/project/project_service.dart';
import 'package:flutter_job_timer_dw/app/view_model/project_task_model.dart';
import 'package:flutter_job_timer_dw/app/view_model/project_model.dart';

class ProjectServiceFirebaseImpl implements ProjectService {
  final ProjectRepositoryFirebase _projectRepository;

  ProjectServiceFirebaseImpl(
      {required ProjectRepositoryFirebase projectRepository})
      : _projectRepository = projectRepository;
  @override
  Future<void> register(ProjectModel project) async {
    final projectMap = project.toMap();
    await _projectRepository.register(projectMap);
  }

  @override
  Future<List<ProjectModel>> findByStatus(ProjectStatus status) async {
    final projects = _projectRepository.findByStatus(status.index);

    return projects.map((e) => ProjectModel.fromMap(e)).toList();
  }

  @override
  Future<void> addTask(int projectId, ProjectTaskModel task) async {
    final taskMap = task.toMap();
    await _projectRepository.addTask(projectId.toString(), taskMap);
  }

  @override
  Future<void> finish(int projectId) async {
    await _projectRepository.finish(projectId);
  }

  @override
  Future<ProjectModel> findById(int projectId) async {
    final projectEntity = await _projectRepository.findById(projectId);
    final project = ProjectModel.fromEntity(projectEntity);
    return project;
  }

  @override
  Future<File> getPdfFile(String url) async {
    return await _projectRepository.getFileByUrl(url);
  }
}
