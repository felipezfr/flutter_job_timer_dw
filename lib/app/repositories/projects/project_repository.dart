import 'package:flutter_job_timer_dw/app/entities/project.dart';
import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
import 'package:flutter_job_timer_dw/app/entities/project_task.dart';

abstract class ProjectRepository {
  Future<void> register(Project project);
  Future<List<Project>> findByStatus(ProjectStatus status);
  Future<void> addTask(int projectId, ProjectTask taskEntity);
  Future<void> finish(int projectId);
  Future<Project> findById(int projectId);
}
