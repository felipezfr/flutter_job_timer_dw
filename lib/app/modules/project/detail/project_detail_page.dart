import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_job_timer_dw/app/core/ui/job_timer_icons.dart';
import 'package:flutter_job_timer_dw/app/entities/project_entity.dart';
import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
import 'package:flutter_job_timer_dw/app/modules/project/detail/controller/project_detail_controller.dart';
import 'package:flutter_job_timer_dw/app/modules/project/detail/controller/project_detail_state.dart';
import 'package:flutter_job_timer_dw/app/modules/project/detail/widgets/header_project_detail.dart';
import 'package:flutter_job_timer_dw/app/modules/project/detail/widgets/pia_chart_detail.dart';
import 'package:flutter_job_timer_dw/app/modules/project/detail/widgets/task_tile.dart';

class ProjectDetailPage extends StatelessWidget {
  final ProjectDetailController controller;
  const ProjectDetailPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<ProjectDetailController, ProjectDetailState>(
      bloc: controller,
      listener: (context, state) {
        if (state.projectDetailState == ProjectDetailStatus.failure) {
          AsukaSnackbar.alert('Erro interno');
        }
      },
      builder: (context, state) {
        final projectModel = state.project;

        switch (state.projectDetailState) {
          case ProjectDetailStatus.initial:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ProjectDetailStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case ProjectDetailStatus.failure:
            AsukaSnackbar.alert('Erro ao carregar projeto.').show();
            break;

          case ProjectDetailStatus.complete:
            return Body(
              project: projectModel!,
              controller: controller,
            );
        }
        return Container();
      },
    ));
  }
}

class Body extends StatelessWidget {
  final Project project;
  final ProjectDetailController controller;
  const Body({
    Key? key,
    required this.project,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalTask = project.tasks.fold<int>(
      0,
      (totalValue, task) {
        return totalValue += task.duration;
      },
    );

    return CustomScrollView(
      slivers: [
        HeaderProjectDetail(project: project),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 30,
          ),
        ),
        SliverToBoxAdapter(
          child: ProjectPieChart(
            projectEstimate: project.estimate,
            totalTask: totalTask,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            project.tasks.map((task) => TaskTile(task: task)).toList(),
          ),
        ),
        SliverFillRemaining(
          child: Visibility(
            visible: project.status == ProjectStatus.em_andamento,
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
        ),
      ],
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
