import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
import 'package:isar/isar.dart';

class ProjectStatusConverter extends TypeConverter<ProjectStatus, int> {
  const ProjectStatusConverter();

  @override
  fromIsar(int object) {
    return ProjectStatus.values[object];
  }

  @override
  int toIsar(object) {
    return object.index;
  }
}
