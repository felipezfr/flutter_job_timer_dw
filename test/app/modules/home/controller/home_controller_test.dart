import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_job_timer_dw/app/entities/project_entity.dart';
import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
import 'package:flutter_job_timer_dw/app/modules/home/controller/home_controller.dart';
import 'package:flutter_job_timer_dw/app/modules/home/controller/home_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../repositories/projects/mocks/mocks.dart';

void main() {
  late ProjectServiceMock projectService;
  // late ProjectRepositoryMock projectRepository;
  late AuthServiceMock authService;
  late HomeController bloc;

  setUp(
    () {
      projectService = ProjectServiceMock();
      // projectRepository = ProjectRepositoryMock();
      authService = AuthServiceMock();

      bloc = HomeController(
        authService: authService,
        projectService: projectService,
      );
    },
  );

  blocTest<HomeController, HomeState>(
    'Home bloc singOut',
    build: () {
      when(() => authService.signOut()).thenAnswer((_) => Future.value());
      return bloc;
    },
    act: (bloc) => bloc.signOut(),
    expect: () => [
      const HomeState(
          status: HomeStatus.loading,
          errorMessage: null,
          projectFilter: ProjectStatus.em_andamento,
          projects: [])
    ],
    verify: (_) async {
      verify(() => authService.signOut()).called(1);
    },
  );

  blocTest<HomeController, HomeState>(
    'Home bloc singOut whith Error',
    build: () {
      when(() => authService.signOut())
          .thenAnswer((_) => Future.error('Error'));
      return bloc;
    },
    act: (bloc) => bloc.signOut(),
    expect: () => [
      const HomeState(
          status: HomeStatus.loading,
          errorMessage: null,
          projectFilter: ProjectStatus.em_andamento,
          projects: []),
      const HomeState(
        status: HomeStatus.failure,
        errorMessage: 'Erro ao fazer logof',
        projectFilter: ProjectStatus.em_andamento,
        projects: [],
      )
    ],
    verify: (_) async {
      verify(() => authService.signOut()).called(1);
    },
  );
  final proj = Project(
      name: 'name', estimate: 2, status: ProjectStatus.em_andamento, tasks: []);
  blocTest<HomeController, HomeState>(
    'Home bloc loadProjects ',
    build: () {
      when(() => projectService.findByStatusStream(ProjectStatus.em_andamento))
          .thenAnswer((_) => Stream.value([proj]));
      return bloc;
    },
    act: (bloc) => bloc.loadProjects(),
    expect: () => [
      const HomeState(
          status: HomeStatus.loading,
          errorMessage: null,
          projectFilter: ProjectStatus.em_andamento,
          projects: []),
      HomeState(
        status: HomeStatus.complete,
        errorMessage: null,
        projectFilter: ProjectStatus.em_andamento,
        projects: [proj],
      )
    ],
    verify: (_) async {
      verify(() =>
              projectService.findByStatusStream(ProjectStatus.em_andamento))
          .called(1);
    },
  );

  blocTest<HomeController, HomeState>(
    'Home bloc loadProjects with error',
    build: () {
      when(() => projectService.findByStatusStream(ProjectStatus.em_andamento))
          .thenAnswer((_) => Stream.error(Exception('Error')));
      return bloc;
    },
    act: (bloc) => bloc.loadProjects(),
    expect: () => [
      const HomeState(
          status: HomeStatus.loading,
          errorMessage: null,
          projectFilter: ProjectStatus.em_andamento,
          projects: []),
      const HomeState(
        status: HomeStatus.failure,
        errorMessage: 'Erro ao carregar projetos',
        projectFilter: ProjectStatus.em_andamento,
        projects: [],
      )
    ],
    verify: (_) async {
      verify(() =>
              projectService.findByStatusStream(ProjectStatus.em_andamento))
          .called(1);
    },
  );

  blocTest<HomeController, HomeState>(
    'Home bloc filter',
    build: () {
      when(() => projectService.findByStatus(ProjectStatus.finalizado))
          .thenAnswer((_) => Future.value([proj]));
      return bloc;
    },
    act: (bloc) => bloc.filter(ProjectStatus.finalizado),
    expect: () => [
      const HomeState(
          status: HomeStatus.loading,
          errorMessage: null,
          projectFilter: ProjectStatus.finalizado,
          projects: []),
      HomeState(
        status: HomeStatus.complete,
        errorMessage: null,
        projectFilter: ProjectStatus.finalizado,
        projects: [proj],
      )
    ],
    verify: (_) async {
      verify(() => projectService.findByStatus(ProjectStatus.finalizado))
          .called(1);
    },
  );

  blocTest<HomeController, HomeState>(
    'Home bloc filter with error',
    build: () {
      when(() => projectService.findByStatus(ProjectStatus.finalizado))
          .thenAnswer((_) => Future.error('Error'));
      return bloc;
    },
    act: (bloc) => bloc.filter(ProjectStatus.finalizado),
    expect: () => [
      const HomeState(
          status: HomeStatus.loading,
          errorMessage: null,
          projectFilter: ProjectStatus.finalizado,
          projects: []),
      const HomeState(
        status: HomeStatus.failure,
        errorMessage: 'Erro ao carregar projetos',
        projectFilter: ProjectStatus.finalizado,
        projects: [],
      )
    ],
    verify: (_) async {
      verify(() => projectService.findByStatus(ProjectStatus.finalizado))
          .called(1);
    },
  );
}
