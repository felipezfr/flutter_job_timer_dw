import 'package:flutter_job_timer_dw/app/entities/project_task.dart';

class JsonToTask {
  static ProjectTask fromMap(dynamic map) {
    return ProjectTask(
      id: map['id'],
      name: map['name'],
      duration: map['duration'],
    );
  }

  static Map<String, dynamic> toMap(ProjectTask task) {
    return {
      'id': task.id,
      'name': task.name,
      'duration': task.duration,
    };
  }
}
