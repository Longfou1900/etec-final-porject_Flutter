import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/controller/home_controller.dart';
import 'package:flutter_projects_getx/feature/view/screen/home_body.dart';
import 'package:flutter_projects_getx/feature/view/widgets/home_bottom_nav.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(child: HomeBody()),
        bottomNavigationBar: HomeBottomNav(),
      ),
    );
  }
}
