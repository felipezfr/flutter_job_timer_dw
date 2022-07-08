import 'package:flutter_job_timer_dw/app/core/adapters/task_dto.dart';
import 'package:flutter_job_timer_dw/app/entities/project_entity.dart';
import 'package:flutter_job_timer_dw/app/entities/project_status.dart';

class ProjectDTO {
  static ProjectEntity fromMap(dynamic json) {
    return ProjectEntity(
      id: json['id'],
      name: json['name'],
      estimate: json['estimate'].toInt(),
      // status: JsonToProjectStatus.fromMap(json['status']),
      status: ProjectStatus.values[json['status']],
      tasks: [
        if (json.containsKey('tasks'))
          ...(json['tasks'] as List).map(TaskDTO.fromMap).toList()
      ],
    );
  }

  static Map<String, dynamic> toMap(ProjectEntity proj) {
    return {
      'id': proj.id,
      'name': proj.name,
      'estimate': proj.estimate,
      'status': proj.status.index,
      'tasks': proj.tasks.map((task) => TaskDTO.toMap(task)).toList(),
    };
  }
}
