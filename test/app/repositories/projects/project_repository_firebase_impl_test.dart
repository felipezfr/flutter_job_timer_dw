import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_job_timer_dw/app/repositories/projects/project_repository_firebase_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('deve adicionar um novo project a collection projects', () async {
    final firestore = FakeFirebaseFirestore();
    final datasource =
        ProjectRepositoryFirebaseImpl(firebaseFirestore: firestore);

    final project = {
      'id': '123123',
      'name': 'Teste Projeto',
      'estimate': 120,
      'status': 0,
      'tasks': [],
    };

    await datasource.register(project);

    final ref = firestore.collection('projects');
    final queues = await ref.get();

    expect(queues.docs.length, 1);
    expect(queues.docs.first.data().containsKey('id'), false);
    expect(queues.docs.first.data()['name'], 'Teste Projeto');
    expect(queues.docs.first.data()['estimate'], 120);
    expect(queues.docs.first.data()['status'], 0);
    expect(queues.docs.first.data()['tasks'], []);
  });

  test('deve retorar um projeto pelo id', () async {
    final firestore = FakeFirebaseFirestore();
    final project = await firestore.collection('projects').add(
      {
        // 'id': 'HdhausdhAdha',
        'name': 'Teste Projeto',
        'estimate': 120,
        'status': 0,
        'tasks': [],
      },
    );

    final datasource =
        ProjectRepositoryFirebaseImpl(firebaseFirestore: firestore);
    final result = await datasource.findById(project.id);

    expect(result, isA<Map>());
    expect(result['id'], project.id);
    expect(result['name'], 'Teste Projeto');
    expect(result['estimate'], 120);
    expect(result['status'], 0);
    expect(result['tasks'], []);
  });

  test('deve retorar todos projetos com status em andamento', () async {
    final firestore = FakeFirebaseFirestore();
    final project = await firestore.collection('projects').add(
      {
        'name': 'Teste Projeto',
        'estimate': 120,
        'status': 0,
        'tasks': [],
      },
    );

    final project2 = await firestore.collection('projects').add(
      {
        'name': 'Projeto 2',
        'estimate': 48,
        'status': 0,
        'tasks': [],
      },
    );
    final project3 = await firestore.collection('projects').add(
      {
        'name': 'Projeto 3',
        'estimate': 25,
        'status': 1,
        'tasks': [],
      },
    );

    final datasource =
        ProjectRepositoryFirebaseImpl(firebaseFirestore: firestore);
    final result = await datasource.findByStatus(0);

    expect(result, isA<List<Map>>());
    expect(result.length, 2);
    expect(result.first['name'], 'Teste Projeto');
    expect(result.last['name'], 'Projeto 2');
  });

  test('deve retorar todos projetos com status finalizado', () async {
    final firestore = FakeFirebaseFirestore();
    final project = await firestore.collection('projects').add(
      {
        'name': 'Teste Projeto',
        'estimate': 120,
        'status': 1,
        'tasks': [],
      },
    );

    final project2 = await firestore.collection('projects').add(
      {
        'name': 'Projeto 2',
        'estimate': 48,
        'status': 0,
        'tasks': [],
      },
    );

    final datasource =
        ProjectRepositoryFirebaseImpl(firebaseFirestore: firestore);
    final result = await datasource.findByStatus(1);

    expect(result, isA<List<Map>>());
    expect(result.length, 1);
    expect(result.first['name'], 'Teste Projeto');
  });

  test('deve mudar o status de um projeto para finalizado', () async {
    final firestore = FakeFirebaseFirestore();
    final project = await firestore.collection('projects').add(
      {
        'name': 'Teste Projeto',
        'estimate': 120,
        'status': 0,
        'tasks': [],
      },
    );

    final datasource =
        ProjectRepositoryFirebaseImpl(firebaseFirestore: firestore);

    await datasource.finish(project.id);

    final result = await datasource.findById(project.id);

    expect(result['status'], 1);
  });

  test('deve adicionar uma task a um projeto', () async {
    final firestore = FakeFirebaseFirestore();
    final project = await firestore.collection('projects').add(
      {
        'name': 'Teste Projeto task',
        'estimate': 98,
        'status': 0,
        'tasks': [],
      },
    );

    final task = {
      'name': 'Nova task',
      'duration': 12,
    };
    final task2 = {
      'name': 'Segunda task',
      'duration': 24,
    };

    final datasource =
        ProjectRepositoryFirebaseImpl(firebaseFirestore: firestore);

    await datasource.addTask(project.id, task);
    await datasource.addTask(project.id, task2);

    final result = await datasource.findById(project.id);

    expect(result['tasks'], isA<List>());
    expect(result['tasks'].first['name'], 'Nova task');
    expect(result['tasks'].first['duration'], 12);
    expect(result['tasks'].last['name'], 'Segunda task');
    expect(result['tasks'].last['duration'], 24);
  });
}
