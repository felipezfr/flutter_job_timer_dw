import 'package:flutter/material.dart';

import 'package:flutter_job_timer_dw/app/modules/project/detail/widgets/header_project_detail.dart';
import 'package:flutter_job_timer_dw/app/modules/project/detail/widgets/task_tile.dart';
import 'package:flutter_job_timer_dw/app/view_model/project_model.dart';

class ProjectDetailPage extends StatelessWidget {
  final ProjectModel project;
  const ProjectDetailPage({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          HeaderProjectDetail(project: project),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
                project.tasks.map((task) => TaskTile(task: task)).toList()),
          )
        ],
      ),
    );
  }
}
