import 'package:flutter_job_timer_dw/app/entities/project_entity.dart';
import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
import 'package:flutter_job_timer_dw/app/entities/project_task.dart';
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

    expect(result, isA<List<ProjectEntity>>());
    expect(result.length, 2);
    expect(result.first.id, 'aZasdAASDnasdj');
    expect(result.first.name, 'Teste Projeto');
    expect(result.first.estimate, 120);
    expect(result.first.tasks.length, 2);
    expect(result.first.tasks.first.name, 'Nova task');
    expect(result.first.tasks.last.duration, 15);
  });

  test('deve buscar os projetos com status em andamento como Stream', () async {
    final repository = ProjectRepositoryMock();
    when(() => repository.findByStatusStream(ProjectStatus.em_andamento.index))
        .thenAnswer(
      (_) => Stream.value([
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
    final result = service.findByStatusStream(ProjectStatus.em_andamento);

    expect(result, emits(isA<List<ProjectEntity>>()));
  });

  test('deve buscar um projeto pelo id', () async {
    final repository = ProjectRepositoryMock();
    when(() => repository.findById('qwertyuiop')).thenAnswer(
      (_) => Future.value({
        'id': 'qwertyuiop',
        'name': 'Teste Projeto',
        'estimate': 110,
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
      }),
    );

    final service = ProjectServiceFirebaseImpl(projectRepository: repository);
    final result = await service.findById('qwertyuiop');

    expect(result, isA<ProjectEntity>());
    expect(result.id, 'qwertyuiop');
    expect(result.name, 'Teste Projeto');
    expect(result.estimate, 110);
    expect(result.tasks.length, 2);
    expect(result.tasks.first.name, 'Nova task');
    expect(result.tasks.last.duration, 15);
  });

  test('deve buscar um projeto pelo id Stream', () async {
    final repository = ProjectRepositoryMock();
    when(() => repository.findByIdStream('qwertyuiop')).thenAnswer(
      (_) => Stream.value({
        'id': 'qwertyuiop',
        'name': 'Teste Projeto',
        'estimate': 110,
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
      }),
    );

    final service = ProjectServiceFirebaseImpl(projectRepository: repository);
    final result = service.findByIdStream('qwertyuiop');

    expect(result, emits(isA<ProjectEntity>()));
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

  test('deve adicionar uma task a um projeto', () {
    final repository = ProjectRepositoryMock();

    final task = ProjectTask(
      // id: '1657214670912565',
      name: 'Novo Projeto',
      duration: 38,
    );

    when(() => repository.addTask(
          any(),
          any(),
        )).thenAnswer((_) => Future<void>.value());

    final service = ProjectServiceFirebaseImpl(projectRepository: repository);

    expect(service.addTask('awasdta', task), completes);
  });

  test('deve finalizar um projeto', () {
    final repository = ProjectRepositoryMock();

    when(() => repository.finish(any()))
        .thenAnswer((_) => Future<void>.value());

    final service = ProjectServiceFirebaseImpl(projectRepository: repository);

    expect(service.finish('awasdta'), completes);
  });
}
