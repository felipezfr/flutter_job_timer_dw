import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_job_timer_dw/app/modules/home/controller/home_controller.dart';
import 'package:flutter_job_timer_dw/app/modules/home/controller/home_state.dart';
import 'package:flutter_job_timer_dw/app/modules/home/widgets/header_projects_menu.dart';
import 'package:flutter_job_timer_dw/app/modules/home/widgets/project_tile.dart';
import 'package:flutter_job_timer_dw/app/view_model/project_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  final HomeController controller;
  const HomePage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                title: const Text(
                  'Sair',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: const Icon(
                  Icons.logout,
                  color: Colors.black87,
                ),
                onTap: () => controller.signOut(),
              ),
              ListTile(
                title: const Text(
                  'Storage',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: const Icon(
                  Icons.storage,
                  color: Colors.black87,
                ),
                onTap: () async => await Modular.to.pushNamed('/storage'),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text(
                'Projetos',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: Theme.of(context).primaryColor,
              expandedHeight: 100,
              toolbarHeight: 100,
              centerTitle: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: HeaderProjectsMenu(controller: controller),
              pinned: true,
            ),
            BlocSelector<HomeController, HomeState, bool>(
              bloc: controller,
              selector: (state) => state.status == HomeStatus.loading,
              builder: (context, showLoading) {
                return SliverVisibility(
                  visible: showLoading,
                  sliver: const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 50,
                      child:
                          Center(child: CircularProgressIndicator.adaptive()),
                    ),
                  ),
                );
              },
            ),
            BlocSelector<HomeController, HomeState, List<ProjectModel>>(
              bloc: controller,
              selector: (state) => state.projects,
              builder: (context, projects) {
                return SliverList(
                  delegate: SliverChildListDelegate(projects
                      .map((e) => ProjectTile(projectModel: e))
                      .toList()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
