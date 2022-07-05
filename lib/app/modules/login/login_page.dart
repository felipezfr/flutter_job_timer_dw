import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_job_timer_dw/app/modules/login/controller/login_controller.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  LoginController controller;

  LoginPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocListener<LoginController, LoginState>(
      bloc: widget.controller,
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
        body: SingleChildScrollView(
          child: Container(
            width: screenSize.width,
            height: screenSize.height,
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
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailEC,
                          decoration: const InputDecoration(
                            label: Text('Email'),
                            fillColor: Colors.grey,
                          ),
                          validator:
                              Validatorless.required('Email obrigatorio'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: passwordEC,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            label: Text('Senha'),
                          ),
                          validator: Validatorless.multiple(
                            [
                              Validatorless.required('Senha obrigatoria'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () async {
                      await widget.controller
                          .signIn(emailEC.text, passwordEC.text);
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.grey[200]),
                    child: const Text('Entrar'),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () async {
                      await widget.controller.signInGoogle();
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.grey[200]),
                    child: Image.asset('assets/images/google.png'),
                  ),
                ),
                BlocSelector<LoginController, LoginState, bool>(
                  bloc: widget.controller,
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
      ),
    );
  }
}
