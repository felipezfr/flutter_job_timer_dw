import 'package:flutter_job_timer_dw/app/core/adapters/json_to_project_status.dart';
import 'package:flutter_job_timer_dw/app/core/adapters/json_to_task.dart';
import 'package:flutter_job_timer_dw/app/entities/project_entity.dart';

class JsonToProject {
  static ProjectEntity fromMap(dynamic json) {
    return ProjectEntity(
      id: json['id'],
      name: json['name'],
      estimate: json['estimate'],
      status: JsonToProjectStatus.fromMap(json['status']?.toInt()),
      tasks: [
        if (json.containsKey('tasks'))
          ...(json['tasks'] as List).map(JsonToTask.fromMap).toList()
      ],
    );
  }

  static Map<String, dynamic> toMap(ProjectEntity proj) {
    return {
      'id': proj.id,
      'name': proj.name,
      'estimate': proj.estimate,
      'status': proj.status,
      'tasks': proj.tasks.map((task) => JsonToTask.toMap(task)).toList(),
    };
  }
}
