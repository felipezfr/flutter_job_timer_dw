import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_job_timer_dw/app/core/exceptions/failure.dart';

import 'package:flutter_job_timer_dw/app/repositories/projects/project_repository_firebase.dart';

class ProjectRepositoryFirebaseImpl extends ProjectRepositoryFirebase {
  final FirebaseFirestore _firestore;

  ProjectRepositoryFirebaseImpl({
    required FirebaseFirestore firebaseFirestore,
  }) : _firestore = firebaseFirestore;

  @override
  Future<void> addTask(
      String projectId, Map<String, dynamic> taskEntity) async {}

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
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Stream<List<Map>> findByStatus(int status) {
    final ref = _firestore.collection('projects');
    final snapshot = ref.where('status', isEqualTo: status).snapshots();

    return snapshot.map((event) => event.docs).map(_convert);
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
  Future<String> getFilePathByUrl(String url) {
    // TODO: implement getFilePathByUrl
    throw UnimplementedError();
  }

  @override
  Future<void> register(Map<String, dynamic> project) async {
    final ref = _firestore.collection('projects');
    project.remove('id');
    ref.add(project);
  }

  List<Map> _convert(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    return docs
        .map((document) => {
              'id': document.id,
              ...document.data(),
            })
        .toList();
  }
}
