import 'package:flutter/material.dart';
import 'package:flutter_job_timer_dw/app/core/ui/app_config.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:asuka/asuka.dart' as asuka;

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Job',
      debugShowCheckedModeBanner: false,
      theme: AppConfig.theme3,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      builder: asuka.builder,
    );
  }
}
