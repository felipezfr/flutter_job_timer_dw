import 'package:flutter_job_timer_dw/app/modules/home/home_module.dart';
import 'package:flutter_job_timer_dw/app/modules/login/login_module.dart';
import 'package:flutter_job_timer_dw/app/modules/splash/splash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> binds = [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const SplashPage()),
        ModuleRoute('/login', module: LoginModule()),
        ModuleRoute('/home', module: HomeModule()),
      ];
}
