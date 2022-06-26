import 'package:bloc/bloc.dart';
import 'package:flutter_job_timer_dw/app/modules/project/detail/controller/project_detail_state.dart';

class ProjectDetailController extends Cubit<ProjectDetailStatus> {
  ProjectDetailController() : super(ProjectDetailStatus.initial);
}
