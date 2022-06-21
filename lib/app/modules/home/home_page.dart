import 'package:flutter/material.dart';
import 'package:flutter_job_timer_dw/app/modules/home/controller/home_controller.dart';
import 'package:flutter_job_timer_dw/app/modules/home/widgets/header_projects_menu.dart';

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
          child: ListTile(
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
        ),
      ),
      body: SafeArea(
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
              delegate: HeaderProjectsMenu(
                controller: controller,
              ),
            )
          ],
        ),
      ),
    );
  }
}
