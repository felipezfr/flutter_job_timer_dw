import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
import 'package:flutter_job_timer_dw/app/modules/home/controller/home_state.dart';
import 'package:flutter_job_timer_dw/app/service/auth/auth_service.dart';
import 'package:flutter_job_timer_dw/app/service/project/project_service.dart';

class HomeController extends Cubit<HomeState> {
  final AuthService _authService;
  final ProjectService _projectService;

  HomeController(
      {required AuthService authService,
      required ProjectService projectService})
      : _authService = authService,
        _projectService = projectService,
        super(HomeState.initial());

  Future<void> signOut() async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      await _authService.signOut();
    } catch (e) {
      emit(
        state.copyWith(
            status: HomeStatus.failure, errorMessage: 'Erro ao fazer logof'),
      );
    }
  }

  Future<void> loadProjects() async {
    emit(state.copyWith(status: HomeStatus.loading));

    _projectService.findByStatusStream(state.projectFilter).listen(
      (projects) {
        // emit(state.copyWith(status: HomeStatus.loading));
        print("snapshoot");
        emit(
          state.copyWith(
            status: HomeStatus.complete,
            projects: projects.where(
              (element) {
                return state.projectFilter == element.status;
              },
            ).toList(),
          ),
        );
      },
    ).onError((e) {
      emit(state.copyWith(
          status: HomeStatus.failure,
          errorMessage: 'Erro ao carregar projetos'));
    });
  }

  Future<void> filter(ProjectStatus status) async {
    emit(state.copyWith(status: HomeStatus.loading, projectFilter: status));
    try {
      final projects = await _projectService.findByStatus(state.projectFilter);
      emit(state.copyWith(status: HomeStatus.complete, projects: projects));
    } catch (e) {
      emit(state.copyWith(
          status: HomeStatus.failure,
          errorMessage: 'Erro ao carregar projetos'));
    }
  }

  // Future<void> loadProjects() async {
  //   emit(state.copyWith(status: HomeStatus.loading));
  //   final projects = await _projectService.findByStatus(state.projectFilter);
  //   emit(state.copyWith(status: HomeStatus.complete, projects: projects));
  // }
}
