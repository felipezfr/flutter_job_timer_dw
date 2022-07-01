import 'package:flutter_job_timer_dw/app/entities/project_status.dart';

class JsonToProjectStatus {
  static ProjectStatus fromMap(int index) {
    final status =
        ProjectStatus.values.where((element) => element.index == index).first;
    return status;
  }
}
