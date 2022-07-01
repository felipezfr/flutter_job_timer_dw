import 'package:flutter/material.dart';
import 'package:flutter_job_timer_dw/app/core/ui/job_timer_icons.dart';
import 'package:flutter_job_timer_dw/app/entities/project_entity.dart';
import 'package:flutter_job_timer_dw/app/modules/home/controller/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProjectTile extends StatelessWidget {
  final ProjectEntity projectEntity;

  const ProjectTile({super.key, required this.projectEntity});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Modular.to
            .pushNamed('/project/detail/', arguments: projectEntity);
        Modular.get<HomeController>().loadProjects();
      },
      child: Container(
          constraints: const BoxConstraints(maxHeight: 90),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey[300]!,
                width: 4,
              )),
          child: Column(
            children: [
              _ProjectName(projectEntity: projectEntity),
              Expanded(child: _ProjectProgress(projectEntity: projectEntity)),
            ],
          )),
    );
  }
}

class _ProjectName extends StatelessWidget {
  final ProjectEntity projectEntity;

  const _ProjectName({required this.projectEntity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(projectEntity.name),
          Icon(
            JobTimerIcons.angle_double_right,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}

class _ProjectProgress extends StatelessWidget {
  final ProjectEntity projectEntity;

  const _ProjectProgress({required this.projectEntity});

  @override
  Widget build(BuildContext context) {
    final totalTasks = projectEntity.tasks
        .fold<int>(0, (previousValue, task) => previousValue += task.duration);

    var percent = 0.0;

    if (totalTasks > 0) {
      percent = totalTasks / projectEntity.estimate;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Expanded(
            child: LinearProgressIndicator(
              value: percent,
              backgroundColor: Colors.grey[400]!,
              color: percent > 1 ? Colors.red : Theme.of(context).primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text('${projectEntity.estimate}h'),
          )
        ],
      ),
    );
  }
}
