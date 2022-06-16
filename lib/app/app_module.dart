import 'package:flutter_job_timer_dw/app/core/database/database.dart';
import 'package:flutter_job_timer_dw/app/core/database/database_impl.dart';
import 'package:flutter_job_timer_dw/app/modules/home/home_module.dart';
import 'package:flutter_job_timer_dw/app/modules/login/login_module.dart';
import 'package:flutter_job_timer_dw/app/modules/splash/splash_page.dart';
import 'package:flutter_job_timer_dw/app/service/auth/auth_service.dart';
import 'package:flutter_job_timer_dw/app/service/auth/auth_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> binds = [
    Bind.lazySingleton<AuthService>((i) => AuthServiceImpl()),
    Bind.lazySingleton<Database>((i) => DatabaseImpl())
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const SplashPage()),
        ModuleRoute('/login', module: LoginModule()),
        ModuleRoute('/home', module: HomeModule()),
      ];
}
