import 'package:flutter_job_timer_dw/app/core/adapters/json_to_task.dart';
import 'package:flutter_job_timer_dw/app/entities/project_entity.dart';
import 'package:flutter_job_timer_dw/app/entities/project_status.dart';

class JsonToProject {
  static Project fromMap(dynamic json) {
    return Project(
      id: json['id'],
      name: json['name'],
      estimate: json['estimate'].toInt(),
      // status: JsonToProjectStatus.fromMap(json['status']),
      status: ProjectStatus.values[json['status']],
      tasks: [
        if (json.containsKey('tasks'))
          ...(json['tasks'] as List).map(JsonToTask.fromMap).toList()
      ],
    );
  }

  static Map<String, dynamic> toMap(Project proj) {
    return {
      'id': proj.id,
      'name': proj.name,
      'estimate': proj.estimate,
      'status': proj.status.index,
      'tasks': proj.tasks.map((task) => JsonToTask.toMap(task)).toList(),
    };
  }
}
