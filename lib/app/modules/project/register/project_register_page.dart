import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import 'package:flutter_job_timer_dw/app/modules/project/register/controller/project_register_controller.dart';

class ProjectRegisterPage extends StatefulWidget {
  final ProjectRegisterController controller;
  const ProjectRegisterPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ProjectRegisterPage> createState() => _ProjectRegisterPageState();
}

class _ProjectRegisterPageState extends State<ProjectRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final estimateHoursEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    estimateHoursEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectRegisterController, ProjectRegisterStatus>(
      bloc: widget.controller,
      listener: ((context, state) {
        switch (state) {
          case ProjectRegisterStatus.failure:
            AsukaSnackbar.alert("Erro ao salvar projeto").show();
            break;
          case ProjectRegisterStatus.success:
            Navigator.pop(context);
            AsukaSnackbar.success("Projeto salvo com succeso").show();
            break;
          default:
        }
      }),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Criar novo projeto'),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameEC,
                    decoration: const InputDecoration(
                      label: Text('Nome do projeto'),
                    ),
                    validator: Validatorless.required('Nome obrigatorio'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: estimateHoursEC,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text('Estimativa de horas'),
                    ),
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Estimativa obrigatorio'),
                        Validatorless.number('Permitido somente numeros')
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocSelector<ProjectRegisterController, ProjectRegisterStatus,
                      bool>(
                    bloc: widget.controller,
                    selector: (state) => state == ProjectRegisterStatus.loading,
                    builder: (context, state) {
                      return Visibility(
                        visible: state,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        final formValid =
                            formKey.currentState?.validate() ?? false;

                        if (formValid) {
                          final name = nameEC.text;
                          final estimate = int.parse(estimateHoursEC.text);
                          await widget.controller.register(name, estimate);
                        }
                      },
                      child: const Text('Salvar'),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
