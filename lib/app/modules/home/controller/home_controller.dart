import 'package:bloc/bloc.dart';
import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
import 'package:flutter_job_timer_dw/app/modules/home/controller/home_state.dart';
import 'package:flutter_job_timer_dw/app/service/auth/auth_service.dart';

class HomeController extends Cubit<HomeState> {
  final AuthService _authService;

  HomeController({required AuthService authService})
      : _authService = authService,
        super(HomeState.initial());

  Future<void> signOut() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      await _authService.signOut();
      emit(state.copyWith(status: HomeStatus.complete));
    } catch (e) {
      emit(
        state.copyWith(
            status: HomeStatus.failure, errorMessage: 'Erro ao fazer logof'),
      );
    }
  }

  Future<void> filter(ProjectStatus status) async {
    emit(state.copyWith(status: HomeStatus.loading));
    emit(state.copyWith(status: HomeStatus.complete, projectFilter: status));
  }

  Future<void> loadProjects() async {
    emit(state.copyWith(status: HomeStatus.loading));
    emit(state.copyWith(status: HomeStatus.complete));
  }
}
