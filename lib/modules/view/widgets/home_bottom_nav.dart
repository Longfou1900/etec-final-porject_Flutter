import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/modules/controller/home_controller.dart';
import 'package:get/get.dart';

class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<HomeController>();

      return BottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        backgroundColor:  Color(0xFF0D1B2A),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        selectedLabelStyle:  TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle:  TextStyle(fontWeight: FontWeight.w400),
        type: BottomNavigationBarType.fixed,
        elevation: 16,
        onTap: controller.setIndex,
        items:  [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      );
    });
  }
}
