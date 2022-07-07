import 'package:flutter_job_timer_dw/app/entities/project_entity.dart';
import 'package:flutter_job_timer_dw/app/modules/project/detail/controller/project_detail_controller.dart';
import 'package:flutter_job_timer_dw/app/modules/project/detail/project_detail_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class ProjectDetailModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        BlocBind.lazySingleton(
          (i) => ProjectDetailController(projectService: i()),
        )
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) {
          final Project projectModel = args.data;
          return ProjectDetailPage(
              controller: Modular.get()..setProject(projectModel));
        })
      ];
}
