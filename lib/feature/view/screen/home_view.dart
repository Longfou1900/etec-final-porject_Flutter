import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/view/screen/home_body.dart';
import 'package:flutter_projects_getx/feature/view/widgets/home_bottom_nav.dart';
import 'package:get/get.dart';
import 'package:flutter_projects_getx/feature/controller/home_controller.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  HomeView({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body updates based on the selected index
      body: Obx(() => IndexedStack(
        index: controller.selectedIndex.value,
        children: const [
          HomeBody(),
          Center(child: Text("Explore Page Content")),
          Center(child: Text("Profile Page Content")),
        ],
      )),
      // Connecting your custom navigation bar
      bottomNavigationBar: const HomeBottomNav(),
    );
  }
}