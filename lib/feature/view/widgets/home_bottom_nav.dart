import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/controller/home_controller.dart';
import 'package:get/get.dart';

class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<HomeController>();

      final scheme = Theme.of(context).colorScheme;

      return Container(
        decoration: BoxDecoration(
          color: scheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.10),
              blurRadius: 14,
              offset: const Offset(0, -6),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            child: BottomNavigationBar(
              currentIndex: controller.selectedIndex.value,
              backgroundColor: scheme.surface,
              selectedItemColor: scheme.primary,
              unselectedItemColor: scheme.onSurface.withValues(alpha: 0.65),
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.w500),
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              onTap: controller.setIndex,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home_outlined, color: Colors.black),
                  activeIcon: const Icon(Icons.home_filled, color: Colors.black),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.explore_outlined, color: Colors.black),
                  activeIcon: const Icon(Icons.explore_rounded, color: Colors.black),
                  label: 'Explore',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.person_outline, color: Colors.black),
                  activeIcon:
                      const Icon(Icons.person_rounded, color: Colors.black),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
