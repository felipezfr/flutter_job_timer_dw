import 'package:equatable/equatable.dart';

import 'package:flutter_job_timer_dw/app/entities/project.dart';

enum HomeStatus {
  initial,
  loading,
  failure,
}

class HomeState extends Equatable {
  final HomeStatus status;
  final String? errorMessage;
  final List<Project>? projects;
  const HomeState({
    required this.status,
    required this.projects,
    this.errorMessage,
  });
  const HomeState._(
      {required this.status, this.errorMessage, required this.projects});

  HomeState.initial() : this._(status: HomeStatus.initial, projects: []);

  @override
  List<Object?> get props => [status, errorMessage];

  HomeState copyWith({
    HomeStatus? status,
    String? errorMessage,
    List<Project>? projects,
  }) {
    return HomeState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      projects: projects ?? this.projects,
    );
  }
}
