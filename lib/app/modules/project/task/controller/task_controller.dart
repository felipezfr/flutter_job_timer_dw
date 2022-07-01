import 'package:bloc/bloc.dart';
import 'package:flutter_job_timer_dw/app/service/project/project_service.dart';
import 'package:flutter_job_timer_dw/app/view_model/project_model.dart';
import 'package:flutter_job_timer_dw/app/view_model/project_task_model.dart';

part 'task_state.dart';

class TaskController extends Cubit<TaskStatus> {
  final ProjectService _projectService;
  late final ProjectModel _projectModel;

  TaskController({required ProjectService projectService})
      : _projectService = projectService,
        super(TaskStatus.inital);

  void setProject(ProjectModel project) => _projectModel = project;

  Future<void> register(String name, int duration) async {
    emit(TaskStatus.loading);

    final task = ProjectTaskModel(
      name: name,
      duration: duration,
    );

    await _projectService.addTask(_projectModel.id.toString(), task);
    emit(TaskStatus.success);
  }
}
