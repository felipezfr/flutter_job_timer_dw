import 'package:bloc/bloc.dart';
import 'package:flutter_job_timer_dw/app/entities/project_status.dart';

import 'package:flutter_job_timer_dw/app/service/project/project_service.dart';
import 'package:flutter_job_timer_dw/app/view_model/project_model.dart';

part 'project_register_state.dart';

class ProjectRegisterController extends Cubit<ProjectRegisterStatus> {
  final ProjectService _projectService;

  ProjectRegisterController({required ProjectService projectService})
      : _projectService = projectService,
        super(ProjectRegisterStatus.initial);

  Future<void> register(String name, int estimate) async {
    try {
      emit(ProjectRegisterStatus.loading);
      final project = ProjectModel(
        name: name,
        estimate: estimate,
        tasks: [],
        status: ProjectStatus.em_andamento,
      );
      await _projectService.register(project);
      emit(ProjectRegisterStatus.success);
    } catch (e) {
      emit(ProjectRegisterStatus.failure);
    }
  }
}
