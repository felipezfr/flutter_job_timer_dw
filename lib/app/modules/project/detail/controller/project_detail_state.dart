import 'package:equatable/equatable.dart';

import 'package:flutter_job_timer_dw/app/view_model/project_model.dart';

enum ProjectDetailStatus {
  initial,
  loading,
  complete,
  failure,
}

class ProjectDetailState extends Equatable {
  late final ProjectModel? project;
  late ProjectDetailStatus projectDetailState;
  ProjectDetailState._({
    required this.project,
    required this.projectDetailState,
  });

  ProjectDetailState.inital()
      : this._(
          project: null,
          projectDetailState: ProjectDetailStatus.initial,
        );

  @override
  List<Object?> get props => [project, projectDetailState];

  ProjectDetailState copyWith({
    ProjectModel? project,
    ProjectDetailStatus? projectDetailState,
  }) {
    return ProjectDetailState._(
      project: project ?? this.project,
      projectDetailState: projectDetailState ?? this.projectDetailState,
    );
  }
}
