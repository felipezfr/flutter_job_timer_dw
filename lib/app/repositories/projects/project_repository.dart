import 'dart:io';

abstract class ProjectRepository {
  Future<void> register(Map<String, dynamic> project);
  // Stream<List<Map>> findByStatus(int status);
  Future<List<Map>> findByStatus(int status);

  Future<void> addTask(String projectId, Map<String, dynamic> taskEntity);
  Future<void> finish(String projectId);
  Future<Map> findById(String projectId);
  Future<File> getFilePathByUrl(String url);
  // Future<void> register(Project project);
  // Future<List<Project>> findByStatus(ProjectStatus status);
  // Future<void> addTask(int projectId, ProjectTask taskEntity);
  // Future<void> finish(int projectId);
  // Future<Project> findById(int projectId);
  // Future<File> getFileByUrl(String url);
}
