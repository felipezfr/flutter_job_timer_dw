import 'package:flutter_job_timer_dw/app/entities/project_entity.dart';
import 'package:flutter_job_timer_dw/app/modules/project/task/controller/task_controller.dart';
import 'package:flutter_job_timer_dw/app/modules/project/task/task_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class TaskModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        BlocBind.lazySingleton((i) => TaskController(projectService: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) {
            final Project projectModel = args.data;
            return TaskPage(
              controller: Modular.get()..setProject(projectModel),
            );
          },
        )
      ];
}
