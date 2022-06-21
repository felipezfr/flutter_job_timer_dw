import 'package:flutter_job_timer_dw/app/modules/project/register/project_register_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProjectModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/register', module: ProjectRegisterModule()),
      ];
}
