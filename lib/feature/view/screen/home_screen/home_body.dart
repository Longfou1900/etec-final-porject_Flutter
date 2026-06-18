import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/controller/home_controller.dart';
import 'package:flutter_projects_getx/feature/view/screen/profile_screen/profile_screen.dart';
import 'package:flutter_projects_getx/feature/view/widgets/explore_tab.dart';
import 'package:flutter_projects_getx/feature/view/widgets/home_app_bar.dart';
import 'package:flutter_projects_getx/feature/view/widgets/home_tab.dart';
import 'package:get/get.dart';

class HomeBody extends GetView<HomeController> {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Column(
        children: [
          // 1. Dynamic Header display logic (Only shows on the Home Tab index 0)
          Obx(() {
            return controller.selectedIndex.value == 0
                ? const HomeHeader()
                : const SizedBox.shrink();
          }),

          // 2. Main Content Body Area
          Expanded(
            child: Obx(() {
              if (controller.lodaing.value) {
                return Center(
                  child: CircularProgressIndicator(
                    color: scheme.primary,
                    strokeWidth: 3,
                  ),
                );
              }
              return IndexedStack(
                index: controller.selectedIndex.value,
                children: [
                  // Pass the data cleanly down to your home content list tab
                  HomeTab(controller.homeModel.data),
                  const ExploreTab(),
                  const ProfileScreen(),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}