import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
import 'package:flutter_job_timer_dw/app/entities/project.dart';
import 'package:flutter_job_timer_dw/app/view_model/project_task_model.dart';

class ProjectModel {
  final int? id;
  final String name;
  final int estimate;
  final ProjectStatus status;
  final List<ProjectTaskModel> tasks;

  ProjectModel({
    this.id,
    required this.name,
    required this.estimate,
    required this.status,
    required this.tasks,
  });

  factory ProjectModel.fromEntity(Project project) {
    project.tasks.loadSync();

    return ProjectModel(
      id: project.id,
      name: project.name,
      estimate: project.estimate,
      status: project.status,
      tasks: project.tasks
          .map((task) => ProjectTaskModel.fromEntity(task))
          .toList(),
    );
  }
}
