import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/view/screen/home_screen/home_body.dart';
import 'package:flutter_projects_getx/feature/view/screen/profile_screen/profile_screen.dart';
import 'package:flutter_projects_getx/feature/view/widgets/explore_tab.dart';
import 'package:flutter_projects_getx/feature/view/widgets/home_bottom_nav.dart';
import 'package:get/get.dart';
import 'package:flutter_projects_getx/feature/controller/home/home_controller.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  HomeScreen({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body updates based on the selected index
      body: Obx(() => IndexedStack(
            index: controller.selectedIndex.value,
            children: const [
              HomeBody(),
              ExploreTab(),
              ProfileScreen(),
            ],
          )),
      // Connecting your custom navigation bar
      bottomNavigationBar: const HomeBottomNav(),
    );
  }
}
