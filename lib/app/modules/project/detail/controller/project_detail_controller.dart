import 'package:bloc/bloc.dart';

import 'package:flutter_job_timer_dw/app/modules/project/detail/controller/project_detail_state.dart';
import 'package:flutter_job_timer_dw/app/service/project/project_service.dart';
import 'package:flutter_job_timer_dw/app/view_model/project_model.dart';

class ProjectDetailController extends Cubit<ProjectDetailState> {
  final ProjectService _projectService;
  ProjectDetailController({required ProjectService projectService})
      : _projectService = projectService,
        super(ProjectDetailState.inital());

  void setProject(ProjectModel projectModel) {
    emit(state.copyWith(
        project: projectModel,
        projectDetailState: ProjectDetailStatus.complete));
  }

  Future<void> updateProject() async {
    emit(state.copyWith(projectDetailState: ProjectDetailStatus.loading));
    final project = await _projectService.findById(state.project!.id!);
    emit(state.copyWith(
        projectDetailState: ProjectDetailStatus.complete, project: project));
  }

  Future<void> finishProject() async {
    await _projectService.finish(state.project!.id!);
  }
}
