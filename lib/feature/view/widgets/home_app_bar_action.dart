import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_projects_getx/feature/controller/home_controller.dart';
import 'package:flutter_projects_getx/feature/view/screen/search_screen.dart';
import '../screen/cart_screen.dart';

class HomeAppBarActions extends StatelessWidget {
  const HomeAppBarActions({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Obx(() {
      final isDark = homeController.isDarkMode.value;
      final wrapperColor = isDark
          ? Colors.blueGrey.withValues(alpha: 0.09)
          : Colors.black.withValues(alpha: 0.05);
      final iconColor = isDark ? Colors.blue : Colors.black;

      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildActionButton(
            backgroundColor: wrapperColor,
            icon: Icon(Icons.search, color: iconColor),
            onTap: () => Get.to(() => SearchScreen()),
          ),
          _buildActionButton(
            backgroundColor: wrapperColor,
            icon: Icon(
              isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
              color: iconColor,
            ),
            onTap: homeController.toggleTheme,
          ),
          _buildActionButton(
            margin: const EdgeInsets.only(right: 16),
            backgroundColor: wrapperColor,
            icon: Icon(
              Icons.shopping_bag_outlined,
              color: isDark ? Colors.blue : Colors.black.withValues(alpha: 0.7),
            ),
            onTap: () => Get.to(() => CartScreen()),
          ),
        ],
      );
    });
  }

  Widget _buildActionButton({
    required Color backgroundColor,
    required Widget icon,
    required VoidCallback onTap,
    EdgeInsetsGeometry margin = const EdgeInsets.only(right: 8),
  }) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: icon,
      ),
    );
  }
}