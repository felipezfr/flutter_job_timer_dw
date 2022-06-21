import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class ProjectRegisterPage extends StatefulWidget {
  const ProjectRegisterPage({Key? key}) : super(key: key);

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar novo projeto'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Form(
            // key: formKey,
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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      final formValid =
                          formKey.currentState?.validate() ?? false;
                      if (formValid) {}
                    },
                    child: const Text('Salvar'),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
