import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/controller/home_slide_controller.dart';
import 'package:flutter_projects_getx/feature/view/widgets/home_app_bar_action.dart';
import 'package:flutter_projects_getx/feature/view/widgets/home_app_bar_leading.dart';
import 'package:flutter_projects_getx/feature/view/widgets/home_app_bar_title.dart';
import 'package:flutter_projects_getx/feature/view/widgets/promo_slide.dart';
import 'package:get/get.dart';
import 'package:flutter_projects_getx/feature/controller/home_controller.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    
    // Inject or find the slider animation state management
    final sliderController = Get.isRegistered<HomeSliderController>()
        ? Get.find<HomeSliderController>()
        : Get.put(HomeSliderController());

    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. Normal Modern Standard App Bar Layer
        AppBar(
          backgroundColor: scheme.surface,
          elevation: 0,
          scrolledUnderElevation: 0,
          toolbarHeight: 76,
          leadingWidth: 76,
          leading: const HomeAppBarLeading(),
          titleSpacing: 4,
          title: const HomeAppBarTitle(),
          centerTitle: false,
          actions: const [HomeAppBarActions()],
        ),

        // 2. Beautiful Isolated Banner Slider Area
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Obx(() {
            final items = sliderController.slideItems;

            // Modern Loading/Shimmer framework structure
            if (homeController.lodaing.value || items.isEmpty) {
              return Container(
                height: 160, // Fixed clean frame height matching modern standard aspect ratios
                decoration: BoxDecoration(
                  color: isDark 
                      ? scheme.surfaceContainerLow 
                      : scheme.surfaceContainerHighest.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: scheme.onSurface.withValues(alpha: 0.05),
                  ),
                ),
              );
            }

            return Container(
              height: 160, // Fixed layout ceiling prevents vertical overflow strips completely
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: isDark 
                        ? Colors.black.withValues(alpha: 0.25) 
                        : scheme.primary.withValues(alpha: 0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Slide Builder Layer
                    PageView.builder(
                      controller: sliderController.pageController,
                      itemCount: items.length,
                      onPageChanged: sliderController.updateSlideIndex,
                      itemBuilder: (context, index) {
                        return PromoSlide(item: items[index]);
                      },
                    ),

                    // Navigation Dot Indicator Overlay Dock
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          items.length,
                          (index) => Obx(() {
                            final isSelected = index == sliderController.currentSlide.value;

                            final activeColor = isDark 
                                ? const Color(0xFF8AF05B) 
                                : scheme.primary;
                            final inactiveColor = isDark 
                                ? Colors.white.withValues(alpha: 0.25) 
                                : scheme.onSurface.withValues(alpha: 0.15);

                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOutCubic,
                              width: isSelected ? 18 : 6,
                              height: 6,
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                color: isSelected ? activeColor : inactiveColor,
                                borderRadius: BorderRadius.circular(99),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}