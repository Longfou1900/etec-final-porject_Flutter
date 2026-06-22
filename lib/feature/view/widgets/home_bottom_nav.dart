import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_projects_getx/feature/controller/home/home_controller.dart';

class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Obx(() {
      final currentIndex = controller.selectedIndex.value;

      return Container(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 16), // Elevates the nav into a floating dock
        decoration: BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: isDark 
                  ? Colors.black.withValues(alpha: 0.25) 
                  : scheme.primary.withValues(alpha: 0.06),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Container(
            height: 72,
            decoration: BoxDecoration(
              color: isDark ? scheme.surfaceContainerLow : Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isDark 
                    ? scheme.onSurface.withValues(alpha: 0.05) 
                    : scheme.primary.withValues(alpha: 0.04),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  index: 0,
                  currentIndex: currentIndex,
                  activeIcon: Icons.home_rounded,
                  inactiveIcon: Icons.home_outlined,
                  label: 'Home',
                  scheme: scheme,
                  onTap: controller.setIndex,
                ),
                _buildNavItem(
                  index: 1,
                  currentIndex: currentIndex,
                  activeIcon: Icons.explore_rounded,
                  inactiveIcon: Icons.explore_outlined,
                  label: 'Explore',
                  scheme: scheme,
                  onTap: controller.setIndex,
                ),
                _buildNavItem(
                  index: 2,
                  currentIndex: currentIndex,
                  activeIcon: Icons.person_rounded,
                  inactiveIcon: Icons.person_outline,
                  label: 'Profile',
                  scheme: scheme,
                  onTap: controller.setIndex,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildNavItem({
    required int index,
    required int currentIndex,
    required IconData activeIcon,
    required IconData inactiveIcon,
    required String label,
    required ColorScheme scheme,
    required ValueChanged<int> onTap,
  }) {
    final isActive = index == currentIndex;
    
    // Dynamic smooth transitions between active states
    return InkWell(
      onTap: () => onTap(index),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          // Active pill highlight background
          color: isActive 
              ? scheme.primary.withValues(alpha: 0.12) 
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : inactiveIcon,
              size: 24,
              color: isActive ? scheme.primary : scheme.onSurface.withValues(alpha: 0.5),
            ),
            // Smooth horizontal slide expansion for text label
            AnimatedCrossFade(
              firstChild: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  label,
                  style: TextStyle(
                    color: scheme.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              secondChild: const SizedBox.shrink(),
              crossFadeState: isActive ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 250),
              sizeCurve: Curves.easeInOut,
            ),
          ],
        ),
      ),
    );
  }
}