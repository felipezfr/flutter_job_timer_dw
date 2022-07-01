import 'package:equatable/equatable.dart';
import 'package:flutter_job_timer_dw/app/entities/project_entity.dart';

import 'package:flutter_job_timer_dw/app/entities/project_status.dart';

enum HomeStatus {
  initial,
  loading,
  complete,
  failure,
}

class HomeState extends Equatable {
  final HomeStatus status;
  final List<ProjectEntity> projects;
  final ProjectStatus projectFilter;
  final String? errorMessage;

  const HomeState({
    required this.status,
    required this.projects,
    required this.projectFilter,
    this.errorMessage,
  });
  const HomeState._(
      {required this.status,
      this.errorMessage,
      required this.projects,
      required this.projectFilter});

  HomeState.initial()
      : this._(
          status: HomeStatus.initial,
          projects: [],
          projectFilter: ProjectStatus.em_andamento,
        );

  @override
  List<Object?> get props => [status, errorMessage];

  HomeState copyWith({
    HomeStatus? status,
    List<ProjectEntity>? projects,
    ProjectStatus? projectFilter,
    String? errorMessage,
  }) {
    return HomeState._(
      status: status ?? this.status,
      projects: projects ?? this.projects,
      projectFilter: projectFilter ?? this.projectFilter,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
