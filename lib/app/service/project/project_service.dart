import 'dart:io';

import 'package:flutter_job_timer_dw/app/entities/project_entity.dart';
import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
import 'package:flutter_job_timer_dw/app/entities/project_task.dart';

abstract class ProjectService {
  Future<void> register(Project project);
  Future<List<Project>> findByStatus(ProjectStatus status);
  Future<void> addTask(String projectId, ProjectTask task);
  Future<void> finish(String projectId);
  Future<Project> findById(String projectId);
  Future<File> getPdfFile(String url);
}
