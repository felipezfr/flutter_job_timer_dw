import 'package:flutter_job_timer_dw/app/entities/project_status.dart';

class ProjectStatusDTO {
  static ProjectStatus fromMap(String status) {
    final projStatus =
        ProjectStatus.values.where((element) => element.name == status).first;
    return projStatus;
  }
}
