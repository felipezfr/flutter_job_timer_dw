import 'package:bloc/bloc.dart';
import 'package:flutter_job_timer_dw/app/entities/project_entity.dart';
import 'package:flutter_job_timer_dw/app/entities/project_task.dart';
import 'package:flutter_job_timer_dw/app/service/project/project_service.dart';

part 'task_state.dart';

class TaskController extends Cubit<TaskStatus> {
  final ProjectService _projectService;
  late final ProjectEntity _projectModel;

  TaskController({required ProjectService projectService})
      : _projectService = projectService,
        super(TaskStatus.inital);

  void setProject(ProjectEntity project) => _projectModel = project;

  Future<void> register(String name, int duration) async {
    emit(TaskStatus.loading);

    final task = ProjectTask(
      name: name,
      duration: duration,
    );

    await _projectService.addTask(_projectModel.id.toString(), task);
    emit(TaskStatus.success);
  }
}
