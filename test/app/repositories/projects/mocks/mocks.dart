import 'package:flutter_job_timer_dw/app/repositories/projects/project_repository.dart';
import 'package:flutter_job_timer_dw/app/service/auth/auth_service.dart';
import 'package:flutter_job_timer_dw/app/service/project/project_service.dart';
import 'package:mocktail/mocktail.dart';

class ProjectRepositoryMock extends Mock implements ProjectRepository {}

class ProjectServiceMock extends Mock implements ProjectService {}

class AuthServiceMock extends Mock implements AuthService {}
