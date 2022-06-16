import 'package:flutter_job_timer_dw/app/modules/login/controller/login_controller.dart';
import 'package:flutter_job_timer_dw/app/modules/login/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class LoginModule extends Module {
  @override
  List<Bind<Object>> get binds =>
      [BlocBind.lazySingleton((i) => LoginController(authService: i()))];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => LoginPage(
            controller: Modular.get(),
          ),
        ),
      ];
}
