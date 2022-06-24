import 'package:flutter_job_timer_dw/app/entities/project_task.dart';

class ProjectTaskModel {
  int? id;
  String name;
  int duration;

  ProjectTaskModel({
    this.id,
    required this.name,
    required this.duration,
  });

  factory ProjectTaskModel.fromEntity(ProjectTask projectTask) {
    return ProjectTaskModel(
      id: projectTask.id,
      name: projectTask.name,
      duration: projectTask.duration,
    );
  }
}
