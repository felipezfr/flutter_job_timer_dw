import 'package:flutter/material.dart';
import 'package:flutter_job_timer_dw/app/entities/project_entity.dart';
import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HeaderProjectDetail extends StatelessWidget {
  const HeaderProjectDetail({
    Key? key,
    required this.project,
  }) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(
        project.name,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: Theme.of(context).primaryColor,
      expandedHeight: 100,
      toolbarHeight: 100,
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        ),
      ),
      flexibleSpace: Stack(
        children: [
          Align(
            alignment: const AlignmentDirectional(0, 1.6),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .85,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(
                        0,
                        2,
                      ), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '${project.tasks.length} tasks',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                      height: 56,
                    ),
                    Visibility(
                      visible: project.status != ProjectStatus.finalizado,
                      child: InkWell(
                        onTap: () async {
                          await Modular.to.pushNamed(
                            '/project/task/',
                            arguments: project,
                          );
                          // await Modular.get<ProjectDetailController>()
                          //     .updateProject();
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 6),
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            const Text(
                              'Adicionar Task',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
