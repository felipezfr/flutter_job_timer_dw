import 'package:flutter_job_timer_dw/app/entities/project.dart';
import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
import 'package:flutter_job_timer_dw/app/entities/project_task.dart';
import 'package:flutter_job_timer_dw/app/repositories/projects/project_repository.dart';
import 'package:flutter_job_timer_dw/app/view_model/project_model.dart';
import 'package:flutter_job_timer_dw/app/view_model/project_task_model.dart';

import './project_service.dart';

class ProjectServiceImpl implements ProjectService {
  final ProjectRepository _projectRepository;

  ProjectServiceImpl({required ProjectRepository projectRepository})
      : _projectRepository = projectRepository;

  @override
  Future<void> register(ProjectModel project) async {
    final projectEntity = Project()
      ..name = project.name
      ..id = project.id
      ..estimate = project.estimate
      ..status = project.status;
    await _projectRepository.register(projectEntity);
  }

  @override
  Future<List<ProjectModel>> findByStatus(ProjectStatus status) async {
    final projects = await _projectRepository.findByStatus(status);

    return projects.map((e) => ProjectModel.fromEntity(e)).toList();
  }

  @override
  Future<void> addTask(int projectId, ProjectTaskModel task) async {
    final taskEntity = ProjectTask()
      ..id = task.id
      ..name = task.name
      ..duration = task.duration;
    await _projectRepository.addTask(projectId, taskEntity);
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
}
