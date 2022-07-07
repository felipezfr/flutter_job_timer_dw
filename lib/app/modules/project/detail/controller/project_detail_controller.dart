import 'package:bloc/bloc.dart';
import 'package:flutter_job_timer_dw/app/entities/project_entity.dart';

import 'package:flutter_job_timer_dw/app/modules/project/detail/controller/project_detail_state.dart';
import 'package:flutter_job_timer_dw/app/service/project/project_service.dart';

class ProjectDetailController extends Cubit<ProjectDetailState> {
  final ProjectService _projectService;
  ProjectDetailController({required ProjectService projectService})
      : _projectService = projectService,
        super(ProjectDetailState.inital());

  void setProject(Project projectEntity) {
    emit(state.copyWith(projectDetailState: ProjectDetailStatus.loading));

    emit(state.copyWith(
      project: projectEntity,
      projectDetailState: ProjectDetailStatus.complete,
    ));

    _projectService.findByIdStream(projectEntity.id!).listen((project) {
      print("snapshot Detail");
      emit(state.copyWith(
        project: project,
        projectDetailState: ProjectDetailStatus.complete,
      ));
    });
  }

  // Future<void> updateProject() async {
  //   emit(state.copyWith(projectDetailState: ProjectDetailStatus.loading));
  //   final project = await _projectService.findById(state.project!.id!);
  //   emit(state.copyWith(
  //       projectDetailState: ProjectDetailStatus.complete, project: project));
  // }

  Future<void> finishProject() async {
    emit(state.copyWith(projectDetailState: ProjectDetailStatus.loading));
    try {
      await _projectService.finish(state.project!.id!);
      emit(state.copyWith(projectDetailState: ProjectDetailStatus.complete));
    } catch (e) {
      emit(state.copyWith(projectDetailState: ProjectDetailStatus.failure));
    }
  }
}
