import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_job_timer_dw/app/repositories/projects/project_repository_firebase_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('deve adicionar um novo project a collection projects', () async {
    final firestore = FakeFirebaseFirestore();
    final datasource =
        ProjectRepositoryFirebaseImpl(firebaseFirestore: firestore);

    // int? id;
    // late String name;
    // late int estimate;
    // late ProjectStatus status;
    // final tasks = IsarLinks<ProjectTask>();

    final project = {
      'id': '123123',
      'name': 'Teste Projeto',
      'estimate': 120,
      'status': 0,
      'tasks': []
    };

    datasource.register(project);

    final ref = firestore.collection('projects');
    final queues = await ref.get();

    expect(queues.docs.length, 1);
    expect(queues.docs.first['name'], 'Teste Projeto');
    expect(queues.docs.first.data().containsKey('id'), false);
  });

  test('deve retorar um projeto', () async {
    final firestore = FakeFirebaseFirestore();
    final project = await firestore.collection('projects').add(
      {
        'id': '123123',
        'name': 'Teste Projeto',
        'estimate': 120,
        'status': 0,
        'tasks': []
      },
    );

    final datasource =
        ProjectRepositoryFirebaseImpl(firebaseFirestore: firestore);
    final result = await datasource.findById(project.id);

    expect(result, isA<Map>());
  });

  test('deve retorar todos projetos com status em andamento', () async {
    final firestore = FakeFirebaseFirestore();
    final project = await firestore.collection('projects').add(
      {
        'id': '123123',
        'name': 'Teste Projeto',
        'estimate': 120,
        'status': 0,
        'tasks': []
      },
    );

    final project2 = await firestore.collection('projects').add(
      {
        'id': '456485',
        'name': 'Projeto 2',
        'estimate': 48,
        'status': 0,
        'tasks': []
      },
    );

    final datasource =
        ProjectRepositoryFirebaseImpl(firebaseFirestore: firestore);
    final result = datasource.findByStatus(0);

    expect(result, emits(isA<List<Map>>()));
  });

  test('deve mudar o status de um projeto para finalizado', () async {
    final firestore = FakeFirebaseFirestore();
    final project = await firestore.collection('projects').add(
      {
        'id': '123123',
        'name': 'Teste Projeto',
        'estimate': 120,
        'status': 0,
        'tasks': []
      },
    );

    final datasource =
        ProjectRepositoryFirebaseImpl(firebaseFirestore: firestore);

    await datasource.finish(project.id);

    final result = await datasource.findById(project.id);

    expect(result['status'], 1);
  });
}
