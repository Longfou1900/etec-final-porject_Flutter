import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/controller/home_slide_controller.dart';
import 'package:flutter_projects_getx/feature/view/widgets/home_app_bar_action.dart';
import 'package:flutter_projects_getx/feature/view/widgets/home_app_bar_leading.dart';
import 'package:flutter_projects_getx/feature/view/widgets/home_app_bar_title.dart';
import 'package:flutter_projects_getx/feature/view/widgets/promo_slide.dart';
import 'package:get/get.dart';
import 'package:flutter_projects_getx/feature/controller/home_controller.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final sliderController = Get.put(HomeSliderController());

    return SliverAppBar(
      pinned: true,
      floating: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      expandedHeight: 280,
      toolbarHeight: 76,
      elevation: 0,
      leadingWidth: 76,
      leading: const HomeAppBarLeading(),
      titleSpacing: 10,
      title: const HomeAppBarTitle(),
      centerTitle: false,
      actions: const [HomeAppBarActions()],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 20, right: 20, bottom: 18),
        expandedTitleScale: 1,
        background: Container(
          color: Theme.of(context).colorScheme.surface,
          padding: const EdgeInsets.fromLTRB(20, 98, 20, 18),
          child: Obx(() {
            final items = sliderController.slideItems;
            if (homeController.lodaing.value || items.isEmpty) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(28),
                ),
              );
            }
            return ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  PageView.builder(
                    controller: sliderController.pageController,
                    itemCount: items.length,
                    onPageChanged: sliderController.updateSlideIndex,
                    itemBuilder: (context, index) {
                      return PromoSlide(item: items[index]);
                    },
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 14,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        items.length,
                        (index) => Obx(() {
                          final isSelected = index == sliderController.currentSlide.value;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: isSelected ? 22 : 7,
                            height: 7,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF8AF05B)
                                  : Colors.white.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(99),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}