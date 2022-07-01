import 'package:flutter_job_timer_dw/app/entities/project_entity.dart';
import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
import 'package:flutter_job_timer_dw/app/service/project/project_service_firebase_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../repositories/projects/mocks/mocks.dart';

void main() {
  test('deve buscar os projetos com status em andamento', () async {
    final repository = ProjectRepositoryMock();

    when(() => repository.findByStatus(any())).thenAnswer(
      (_) => Future.value([
        {
          'id': 'aZasdAASDnasdj',
          'name': 'Teste Projeto',
          'estimate': 120,
          'status': 0,
          'tasks': [
            {
              'name': 'Nova task',
              'duration': 12,
            }
          ],
        }
      ]),
    );

    final service = ProjectServiceFirebaseImpl(projectRepository: repository);
    final result = await service.findByStatus(ProjectStatus.em_andamento);

    expect(result, isA<List<ProjectEntity>>());
  });

  test('deve adicionar um novo projeto', () {
    final repository = ProjectRepositoryMock();

    final project = ProjectEntity(
      name: 'Novo Projeto',
      estimate: 34,
      status: ProjectStatus.em_andamento,
      tasks: [],
    );

    when(() => repository.register(any())).thenAnswer((_) => Future.value());

    final service = ProjectServiceFirebaseImpl(projectRepository: repository);

    expect(service.register(project), completes);
  });
}
