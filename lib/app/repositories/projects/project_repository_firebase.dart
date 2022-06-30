abstract class ProjectRepositoryFirebase {
  Future<void> register(Map<String, dynamic> project);
  Stream<List<Map>> findByStatus(int status);
  Future<void> addTask(String projectId, Map<String, dynamic> taskEntity);
  Future<void> finish(String projectId);
  Future<Map> findById(String projectId);
  Future<String> getFilePathByUrl(String url);
}
