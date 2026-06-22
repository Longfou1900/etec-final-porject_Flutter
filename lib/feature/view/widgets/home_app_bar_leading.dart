import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_projects_getx/feature/controller/home/home_controller.dart';

class HomeAppBarLeading extends StatelessWidget {
  const HomeAppBarLeading({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Center(
        child: Obx(() {
          final isDark = homeController.isDarkMode.value;
          return Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.blueGrey.withValues(alpha: 0.09)
                  : Colors.black.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/watch_logo.png',
                width: 25,
                height: 25,
              ),
            ),
          );
        }),
      ),
    );
  }
}