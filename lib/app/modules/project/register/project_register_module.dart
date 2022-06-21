import 'package:flutter_job_timer_dw/app/modules/project/register/project_register_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProjectRegisterModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const ProjectRegisterPage(),
        )
      ];
}
