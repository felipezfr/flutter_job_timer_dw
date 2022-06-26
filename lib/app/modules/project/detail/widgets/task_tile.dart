import 'package:flutter/material.dart';
import 'package:flutter_job_timer_dw/app/view_model/project_task_model.dart';

class TaskTile extends StatelessWidget {
  final ProjectTaskModel task;
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              task.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Duração',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const TextSpan(text: '      '),
                  TextSpan(
                    text: '${task.duration}h',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
