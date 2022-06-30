import 'dart:io';

import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
import 'package:flutter_job_timer_dw/app/view_model/project_model.dart';
import 'package:flutter_job_timer_dw/app/view_model/project_task_model.dart';

abstract class ProjectService {
  Future<void> register(ProjectModel project);
  Future<List<ProjectModel>> findByStatus(ProjectStatus status);
  Future<void> addTask(int projectId, ProjectTaskModel task);
  Future<void> finish(int projectId);
  Future<ProjectModel> findById(int projectId);
  Future<File> getPdfFile(String url);
}
