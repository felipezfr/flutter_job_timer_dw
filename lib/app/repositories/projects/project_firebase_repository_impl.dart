import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_job_timer_dw/app/core/exceptions/failure.dart';
import 'package:flutter_job_timer_dw/app/repositories/projects/project_repository.dart';

class ProjectRepositoryFirebaseImpl extends ProjectRepository {
  final FirebaseFirestore _firestore;

  ProjectRepositoryFirebaseImpl({
    required FirebaseFirestore firebaseFirestore,
  }) : _firestore = firebaseFirestore;

  @override
  Future<void> addTask(
      String projectId, Map<String, dynamic> taskEntity) async {
    final doc = _firestore.collection('projects').doc(projectId);
    taskEntity['id'] =
        taskEntity['id'] ?? DateTime.now().microsecondsSinceEpoch.toString();
    // final task = {
    //   'id': taskId,
    //   ...taskEntity,
    // };
    await doc.update(
      {
        'tasks': FieldValue.arrayUnion([taskEntity]),
      },
    );
  }

  // @override
  // Stream<Map> findById(String projectId) {
  //   try {
  //     final ref = _firestore.collection('projects');
  //     final snapshot = ref.doc(projectId).get();
  //     var data;

  //     snapshot.then((value) {
  //       return value.data();
  //       // return data;
  //     });

  //     return data;
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  @override
  Future<Map> findById(String projectId) async {
    try {
      final ref = _firestore.collection('projects');
      final doc = await ref.doc(projectId).get();
      final data = doc.data()!;
      data.addAll({'id': doc.id});
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<Map>> findByStatus(int status) async {
    final ref = _firestore.collection('projects');
    final proj = await ref.where('status', isEqualTo: status).get();
    final docsList = proj.docs
        .map((document) => {
              'id': document.id,
              ...document.data(),
            })
        .toList();
    return docsList;
  }

  @override
  Future<void> finish(String projectId) async {
    try {
      final doc = _firestore.collection('projects').doc(projectId);
      await doc.update({
        'status': 1,
      });
    } on Exception {
      throw Failure(message: 'Erro ao finalizar projeto');
    }
  }

  @override
  Future<File> getFilePathByUrl(String url) {
    // TODO: implement getFilePathByUrl
    throw UnimplementedError();
  }

  @override
  Future<void> register(Map<String, dynamic> project) async {
    final ref = _firestore.collection('projects');
    project.remove('id');
    ref.add(project).catchError(
          (error, stackTrace) => throw Failure(message: error),
        );
  }

  @override
  Stream<List<Map>> findByStatusStream(int status) {
    final ref = _firestore.collection('projects');

    return ref.snapshots().map(
          (querySnap) => querySnap.docs
              // .where((element) => element.data()['status'] == status)
              .map(
            (doc) {
              return {
                'id': doc.id,
                ...doc.data(),
              };
            },
          ).toList(),
        );
  }

  @override
  Stream<Map> findByIdStream(String projectId) {
    final ref = _firestore.collection('projects').doc(projectId);

    return ref.snapshots().map(
      (doc) {
        return {
          'id': doc.id,
          ...doc.data()!,
        };
      },
    );
  }
}
