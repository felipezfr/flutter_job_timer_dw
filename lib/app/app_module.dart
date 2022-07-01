import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_job_timer_dw/app/core/database/database.dart';
import 'package:flutter_job_timer_dw/app/core/database/database_impl.dart';
import 'package:flutter_job_timer_dw/app/modules/home/home_module.dart';
import 'package:flutter_job_timer_dw/app/modules/login/login_module.dart';
import 'package:flutter_job_timer_dw/app/modules/project/project_module.dart';
import 'package:flutter_job_timer_dw/app/modules/splash/splash_page.dart';
import 'package:flutter_job_timer_dw/app/modules/storage/storage_module.dart';
import 'package:flutter_job_timer_dw/app/repositories/projects/project_repository.dart';
import 'package:flutter_job_timer_dw/app/repositories/projects/project_repository_firebase_impl.dart';
import 'package:flutter_job_timer_dw/app/repositories/storage/storage_repository.dart';
import 'package:flutter_job_timer_dw/app/repositories/storage/storage_repository_impl.dart';
import 'package:flutter_job_timer_dw/app/service/auth/auth_service.dart';
import 'package:flutter_job_timer_dw/app/service/auth/auth_service_impl.dart';
import 'package:flutter_job_timer_dw/app/service/project/project_service.dart';
import 'package:flutter_job_timer_dw/app/service/project/project_service_firebase_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AppModule extends Module {
  @override
  List<Bind> binds = [
    Bind.singleton((i) => FirebaseStorage.instance),
    Bind.singleton((i) => FirebaseFirestore.instance),
    Bind.lazySingleton<StorageRepository>(
        (i) => StorageRepositoryImpl(firebaseStorage: i.get())),
    Bind.lazySingleton<AuthService>((i) => AuthServiceImpl()),
    Bind.lazySingleton<Database>((i) => DatabaseImpl()),
    Bind.lazySingleton<ProjectRepository>(
        (i) => ProjectRepositoryFirebaseImpl(firebaseFirestore: i.get())),
    Bind.lazySingleton<ProjectService>(
        (i) => ProjectServiceFirebaseImpl(projectRepository: i.get())),
    // Bind.lazySingleton<ProjectRepository>(
    //     (i) => ProjectRepositoryImpl(database: i.get(), storage: i.get())),
    // Bind.lazySingleton<ProjectService>(
    //     (i) => ProjectServiceImpl(projectRepository: i.get())),
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const SplashPage()),
        ModuleRoute('/login', module: LoginModule()),
        ModuleRoute('/home', module: HomeModule()),
        ModuleRoute('/project', module: ProjectModule()),
        ModuleRoute('/storage', module: StorageModule()),
      ];
}
