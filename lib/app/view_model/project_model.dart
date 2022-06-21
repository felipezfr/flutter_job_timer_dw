import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
import 'package:flutter_job_timer_dw/app/view_model/project_task_model.dart';

class ProjectModel {
  final int? id;
  final String name;
  final int estimate;
  final ProjectStatus status;
  final List<ProjectTaskModel> taks;

  ProjectModel({
    this.id,
    required this.name,
    required this.estimate,
    required this.status,
    required this.taks,
  });
}
