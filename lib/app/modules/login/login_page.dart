import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_job_timer_dw/app/modules/login/controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginController controller;

  LoginPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocListener<LoginController, LoginState>(
      bloc: controller,
      listenWhen: (previous, current) {
        return previous.status != current.status;
      },
      listener: (context, state) {
        if (state.status == LoginStatus.failure) {
          final message = state.errorMessage ?? 'Erro ao realizar login';
          AsukaSnackbar.alert(message).show();
        }
      },
      child: Scaffold(
        body: Container(
          width: screenSize.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0092B9),
                Color(0xFF0167B2),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png'),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: screenSize.width * 0.8,
                child: ElevatedButton(
                  onPressed: () {
                    controller.signIn();
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.grey[200]),
                  child: Image.asset('assets/images/google.png'),
                ),
              ),
              BlocSelector<LoginController, LoginState, bool>(
                bloc: controller,
                selector: (state) {
                  return state.status == LoginStatus.loading;
                },
                builder: (context, show) {
                  return Visibility(
                    visible: show,
                    child: const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
