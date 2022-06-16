import 'package:flutter/material.dart';
import 'package:flutter_job_timer_dw/app/core/database/database.dart';
import 'package:flutter_job_timer_dw/app/entities/project.dart';
import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: Column(children: [
        ElevatedButton(
          onPressed: () async {
            final db = Modular.get<Database>();

            final connection = await db.openConnetion();
            connection.writeTxn((isar) {
              var project = Project();

              project.name = 'Projeto Teste';
              project.status = ProjectStatus.em_andamento;

              return connection.projects.put(project);
            });
          },
          child: const Text('Cadastrar'),
        ),
      ]),
    );
  }
}
