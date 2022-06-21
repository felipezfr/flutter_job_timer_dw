import 'package:flutter_job_timer_dw/app/view_model/project_model.dart';

abstract class ProjectService {
  Future<void> register(ProjectModel project);
}
