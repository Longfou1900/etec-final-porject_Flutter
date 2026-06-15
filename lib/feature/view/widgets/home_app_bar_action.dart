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
      final theme = Theme.of(context);
      final scheme = theme.colorScheme;
      final isDark = homeController.isDarkMode.value;
      // Modern dynamic colors pulling from the app's native context theme
      final containerBg = isDark 
          ? scheme.surfaceContainerLow 
          : scheme.surfaceContainerHighest.withValues(alpha: 0.4);
      final borderColor = isDark 
          ? scheme.onSurface.withValues(alpha: 0.05) 
          : scheme.primary.withValues(alpha: 0.04);

      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildActionButton(
            backgroundColor: containerBg,
            borderColor: borderColor,
            icon: Icon(Icons.search_rounded, color: scheme.onSurface),
            onTap: () => Get.to(() => const SearchScreen()),
          ),
          _buildActionButton(
            backgroundColor: containerBg,
            borderColor: borderColor,
            icon: Icon(
              isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
              color: isDark ? const Color(0xFF8AF05B) : scheme.primary, // Pop accent color for mode trigger
            ),
            onTap: homeController.toggleTheme,
          ),
          _buildActionButton(
            margin: const EdgeInsets.only(right: 16),
            backgroundColor: containerBg,
            borderColor: borderColor,
            icon: Icon(Icons.shopping_bag_rounded, color: scheme.onSurface),
            onTap: () => Get.to(() => const CartScreen()),
          ),
        ],
      );
    });
  }

  Widget _buildActionButton({
    required Color backgroundColor,
    required Color borderColor,
    required Widget icon,
    required VoidCallback onTap,
    EdgeInsetsGeometry margin = const EdgeInsets.only(right: 8),
  }) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16), // Rounded capsule look to align with the bottom nav
        border: Border.all(color: borderColor, width: 1),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: icon,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        iconSize: 22,
      ),
    );
  }
}