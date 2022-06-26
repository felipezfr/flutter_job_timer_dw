import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_job_timer_dw/app/core/ui/job_timer_icons.dart';
import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
import 'package:flutter_job_timer_dw/app/modules/project/detail/controller/project_detail_controller.dart';
import 'package:flutter_job_timer_dw/app/modules/project/detail/controller/project_detail_state.dart';
import 'package:flutter_job_timer_dw/app/modules/project/detail/widgets/header_project_detail.dart';
import 'package:flutter_job_timer_dw/app/modules/project/detail/widgets/task_tile.dart';
import 'package:flutter_job_timer_dw/app/view_model/project_model.dart';

class ProjectDetailPage extends StatelessWidget {
  final ProjectDetailController controller;
  const ProjectDetailPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BlocSelector<ProjectDetailController, ProjectDetailState,
              ProjectModel>(
            bloc: controller,
            selector: (state) => state.project!,
            builder: (context, project) {
              return HeaderProjectDetail(project: project);
            },
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
            ),
          ),
          BlocSelector<ProjectDetailController, ProjectDetailState,
              ProjectModel>(
            bloc: controller,
            selector: (state) => state.project!,
            builder: (context, project) {
              return SliverList(
                delegate: SliverChildListDelegate(
                    project.tasks.map((task) => TaskTile(task: task)).toList()),
              );
            },
          ),
          // SliverList(
          //   delegate: SliverChildListDelegate(
          //       project.tasks.map((task) => TaskTile(task: task)).toList()),
          // ),
          BlocSelector<ProjectDetailController, ProjectDetailState,
              ProjectStatus>(
            bloc: controller,
            selector: (state) => state.project!.status,
            builder: (context, projectStatus) {
              return SliverFillRemaining(
                child: Visibility(
                  visible: projectStatus == ProjectStatus.em_andamento,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _confirmFinishProject(context);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          primary: Colors.green,
                        ),
                        label: const Text(
                          'Finalizar Projeto',
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: const Icon(
                          JobTimerIcons.ok_circled2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _confirmFinishProject(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Confirma a finalização do projeto?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await controller.finishProject();
                  await controller.updateProject();
                },
                child: const Text(
                  'Confirmar',
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          );
        });
  }
}
