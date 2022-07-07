import 'dart:io';

import 'package:flutter_job_timer_dw/app/entities/project_entity.dart';
import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
import 'package:flutter_job_timer_dw/app/entities/project_task.dart';

abstract class ProjectService {
  Future<void> register(ProjectEntity project);
  Future<List<ProjectEntity>> findByStatus(ProjectStatus status);
  Future<void> addTask(String projectId, ProjectTask task);
  Future<void> finish(String projectId);
  Future<ProjectEntity> findById(String projectId);
  Future<File> getPdfFile(String url);

  Stream<List<ProjectEntity>> findByStatusStream(ProjectStatus status);
  Stream<ProjectEntity> findByIdStream(String projectId);
}
