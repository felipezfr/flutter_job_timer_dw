import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
import 'package:flutter_job_timer_dw/app/entities/project_task.dart';

class ProjectEntity {
  final String? id;
  final String name;
  final int estimate;
  final ProjectStatus status;
  final List<ProjectTask> tasks;
  ProjectEntity({
    this.id,
    required this.name,
    required this.estimate,
    required this.status,
    required this.tasks,
  });
}
