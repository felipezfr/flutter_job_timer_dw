import 'package:flutter_job_timer_dw/app/entities/project.dart';

abstract class ProjectRepository {
  Future<void> register(Project project);
}
