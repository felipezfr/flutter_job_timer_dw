import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_job_timer_dw/app/service/auth/auth_service.dart';

part 'login_state.dart';

class LoginController extends Cubit<LoginState> {
  final AuthService _authService;

  LoginController({required AuthService authService})
      : _authService = authService,
        super(const LoginState.initial());

  Future<void> signInGoogle() async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      await _authService.signInGoogle();
    } catch (e) {
      emit(state.copyWith(
          status: LoginStatus.failure, errorMessage: 'Erro ao realizar login'));
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      await _authService.signIn(email, password);
    } catch (e) {
      emit(state.copyWith(
          status: LoginStatus.failure, errorMessage: 'Erro ao realizar login'));
    }
  }
}
