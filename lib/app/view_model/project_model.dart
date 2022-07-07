// import 'dart:convert';

// import 'package:flutter_job_timer_dw/app/entities/project_entity.dart';
// import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
// import 'package:flutter_job_timer_dw/app/view_model/project_task_model.dart';

// class ProjectModel {
//   final String? id;
//   final String name;
//   final int estimate;
//   final ProjectStatus status;
//   final List<ProjectTaskModel> tasks;

//   ProjectModel({
//     this.id,
//     required this.name,
//     required this.estimate,
//     required this.status,
//     required this.tasks,
//   });

//   factory ProjectModel.fromEntity(Project project) {
//     // project.tasks.loadSync();

//     return ProjectModel(
//       id: project.id.toString(),
//       name: project.name,
//       estimate: project.estimate,
//       status: project.status,
//       tasks: project.tasks
//           .map((task) => ProjectTaskModel.fromEntity(task))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     final result = <String, dynamic>{};

//     if (id != null) {
//       result.addAll({'id': id});
//     }
//     result.addAll({'name': name});
//     result.addAll({'estimate': estimate});
//     result.addAll({'status': status.index});
//     result.addAll({'tasks': tasks.map((x) => x.toMap()).toList()});

//     return result;
//   }

//   factory ProjectModel.fromMap(Map<dynamic, dynamic> map) {
//     return ProjectModel(
//       id: map['id'],
//       name: map['name'] ?? '',
//       estimate: map['estimate']?.toInt() ?? 0,
//       status: map['status']?.toInt() == 0
//           ? ProjectStatus.em_andamento
//           : ProjectStatus.finalizado,
//       tasks: List<ProjectTaskModel>.from(
//           map['tasks']?.map((x) => ProjectTaskModel.fromMap(x))),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory ProjectModel.fromJson(String source) =>
//       ProjectModel.fromMap(json.decode(source));
// }
