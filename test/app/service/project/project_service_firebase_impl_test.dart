import 'package:flutter_job_timer_dw/app/entities/project_entity.dart';
import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
import 'package:flutter_job_timer_dw/app/service/project/project_service_firebase_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../repositories/projects/mocks/mocks.dart';

void main() {
  test('deve buscar os projetos com status em andamento', () async {
    final repository = ProjectRepositoryMock();
    when(() => repository.findByStatus(ProjectStatus.em_andamento.index))
        .thenAnswer(
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
            },
            {
              'name': 'Nova task 2',
              'duration': 15,
            },
          ],
        },
        {
          'id': 'BasdAsdasdad',
          'name': 'Teste Projeto 2',
          'estimate': 20,
          'status': 0,
          'tasks': [
            {
              'name': 'Nova task 2',
              'duration': 3,
            }
          ],
        }
      ]),
    );

    final service = ProjectServiceFirebaseImpl(projectRepository: repository);
    final result = await service.findByStatus(ProjectStatus.em_andamento);

    expect(result, isA<List<Project>>());
    expect(result.length, 2);
    expect(result.first.id, 'aZasdAASDnasdj');
    expect(result.first.name, 'Teste Projeto');
    expect(result.first.estimate, 120);
    expect(result.first.tasks.length, 2);
    expect(result.first.tasks.first.name, 'Nova task');
    expect(result.first.tasks.last.duration, 15);
  });

  test('deve adicionar um novo projeto', () {
    final repository = ProjectRepositoryMock();

    final project = Project(
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
