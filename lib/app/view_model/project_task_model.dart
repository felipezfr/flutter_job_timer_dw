import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'name': name});
    result.addAll({'duration': duration});

    return result;
  }

  factory ProjectTaskModel.fromMap(Map<String, dynamic> map) {
    return ProjectTaskModel(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      duration: map['duration']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectTaskModel.fromJson(String source) =>
      ProjectTaskModel.fromMap(json.decode(source));
}
