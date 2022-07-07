import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_job_timer_dw/app/entities/project_entity.dart';
import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
import 'package:flutter_job_timer_dw/app/modules/project/detail/controller/project_detail_controller.dart';
import 'package:flutter_job_timer_dw/app/modules/project/detail/controller/project_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../repositories/projects/mocks/mocks.dart';

void main() {
  late ProjectServiceMock projectService;
  late ProjectDetailController bloc;

  final proj = Project(
    id: 'qwert',
    name: 'name',
    estimate: 2,
    status: ProjectStatus.em_andamento,
    tasks: [],
  );

  setUp(
    () {
      projectService = ProjectServiceMock();

      bloc = ProjectDetailController(
        projectService: projectService,
      );
    },
  );

  blocTest<ProjectDetailController, ProjectDetailState>(
    'Project Detail bloc finish project',
    build: () {
      when(() => projectService.finish(any()))
          .thenAnswer((_) => Future.value());
      return bloc;
    },
    act: (bloc) {
      bloc.emit(ProjectDetailState(
        project: proj,
        projectDetailState: ProjectDetailStatus.complete,
      ));
      bloc.finishProject();
    },
    expect: () => [
      ProjectDetailState(projectDetailState: ProjectDetailStatus.loading),
      ProjectDetailState(projectDetailState: ProjectDetailStatus.complete),
    ],
    verify: (_) async {
      verify(() => projectService.finish('qwerty')).called(1);
    },
  );
}
