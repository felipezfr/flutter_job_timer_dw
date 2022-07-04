import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_job_timer_dw/app/modules/project/task/controller/task_controller.dart';
import 'package:validatorless/validatorless.dart';

class TaskPage extends StatefulWidget {
  final TaskController controller;

  const TaskPage({super.key, required this.controller});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _durationEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _durationEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskController, TaskStatus>(
      bloc: widget.controller,
      listener: (context, state) {
        if (state == TaskStatus.success) {
          Navigator.pop(context);
        } else if (state == TaskStatus.failure) {
          AsukaSnackbar.alert('Erro ao salvar Task').show();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Criar nova task',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameEC,
                  decoration: const InputDecoration(
                    label: Text('Nome da task'),
                  ),
                  validator: Validatorless.required('Nome obrigatório'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _durationEC,
                  decoration: const InputDecoration(
                    label: Text('Duração da task'),
                  ),
                  keyboardType: TextInputType.number,
                  validator: Validatorless.multiple([
                    Validatorless.required('Duração obrigatória'),
                    Validatorless.number('Permitido somente numeros'),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 49,
                  child: ElevatedButton(
                    child: BlocSelector<TaskController, TaskStatus, bool>(
                      bloc: widget.controller,
                      selector: (state) => state == TaskStatus.loading,
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Center(child: Text('Salvar')),
                            const SizedBox(width: 20),
                            Visibility(
                              visible: state,
                              child: const CircularProgressIndicator(),
                            ),
                          ],
                        );
                      },
                    ),
                    onPressed: () {
                      final formValid =
                          _formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        final duration = int.parse(_durationEC.text);
                        widget.controller.register(_nameEC.text, duration);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class TaskPage extends StatefulWidget {
//   final TaskController controller;
//   // final ProjectModel project;
//   const TaskPage({
//     Key? key,
//     required this.controller,
//     // required this.project,
//   }) : super(key: key);

//   @override
//   State<TaskPage> createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   final formKey = GlobalKey<FormState>();
//   final nameEC = TextEditingController();
//   final estimateHoursEC = TextEditingController();

//   @override
//   void dispose() {
//     nameEC.dispose();
//     estimateHoursEC.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Criar nova Task'),
//         centerTitle: true,
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(20),
//         child: Column(children: [
//           Form(
//             // key: formKey,
//             child: Column(
//               children: [
//                 TextFormField(
//                   controller: nameEC,
//                   decoration: const InputDecoration(
//                     label: Text('Nome da tarefa'),
//                   ),
//                   validator: Validatorless.required('Nome obrigatorio'),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   controller: estimateHoursEC,
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                     label: Text('Duração da tarefa'),
//                   ),
//                   validator: Validatorless.multiple(
//                     [
//                       Validatorless.required('Duração obrigatorio'),
//                       Validatorless.number('Permitido somente numeros')
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 // BlocSelector<ProjectTaskController, ProjectTaskStatus, bool>(
//                 //   bloc: widget.controller,
//                 //   selector: (state) => state == ProjectTaskStatus.loading,
//                 //   builder: (context, state) {
//                 //     return Visibility(
//                 //       visible: state,
//                 //       child: const Center(
//                 //         child: CircularProgressIndicator(),
//                 //       ),
//                 //     );
//                 //   },
//                 // ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       final formValid =
//                           formKey.currentState?.validate() ?? false;

//                       if (formValid) {
//                         // final projectId = widget.project.id!;
//                         final name = nameEC.text;
//                         final estimate = int.parse(estimateHoursEC.text);
//                         // await widget.controller
//                         //     .addTask(projectId, name, estimate);
//                       }
//                     },
//                     child: const Text('Salvar'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }
