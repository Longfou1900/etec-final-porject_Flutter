import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_projects_getx/core/auth/auth_theme.dart';
import 'package:flutter_projects_getx/feature/controller/onborading_controller.dart';
import 'package:flutter_projects_getx/feature/view/screen/onborading/widgets/onboarding_controls.dart';
import 'package:flutter_projects_getx/feature/view/screen/onborading/widgets/onboarding_page.dart';
import 'package:flutter_projects_getx/feature/view/screen/onborading/widgets/onboarding_page_style.dart';
import 'package:get/get.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnboardingController());

    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: _OnboardingBody(),
    );
  }
}

class _OnboardingBody extends StatelessWidget {
  const _OnboardingBody();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();

    return Scaffold(
      backgroundColor: const Color(0xFFE8EAFD),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const _LoadingView();
        }

        return Stack(
          children: [
            const _ScreenBackground(),
            const _OnboardingCardBackground(),
            NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollStartNotification &&
                    notification.dragDetails != null) {
                  controller.pauseAutoScroll();
                }

                if (notification is ScrollEndNotification) {
                  controller.restartAutoScroll();
                }

                return false;
              },
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemBuilder: (context, index) {
                  final itemIndex = controller.itemIndexAt(index);

                  return OnboardingPage(
                    item: controller.onboardingData[itemIndex],
                    style: OnboardingPageStyle.at(itemIndex),
                  );
                },
              ),
            ),
            OnboardingControls(controller: controller),
          ],
        );
      }),
    );
  }
}

class _OnboardingCardBackground extends StatelessWidget {
  const _OnboardingCardBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: const Stack(
        fit: StackFit.expand,
        children: [
          _OrangeShape(
            top: -96,
            left: -92,
            width: 300,
            height: 300,
            rotate: -0.78,
          ),
          _OrangeShape(
            right: -104,
            bottom: -86,
            width: 260,
            height: 260,
          ),
        ],
      ),
    );
  }
}

class _ScreenBackground extends StatelessWidget {
  const _ScreenBackground();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8EAFD),
              Color(0xFFF4F5FF),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrangeShape extends StatelessWidget {
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final double width;
  final double height;
  final double rotate;

  const _OrangeShape({
    this.top,
    this.left,
    this.right,
    this.bottom,
    required this.width,
    required this.height,
    this.rotate = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Transform.rotate(
        angle: rotate,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: AuthTheme.primaryDark,
            borderRadius: BorderRadius.circular(42),
          ),
        ),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFFE8EAFD),
      child: Center(
        child: CircularProgressIndicator(
          color: Color(0xFF272735),
          strokeWidth: 2.4,
        ),
      ),
    );
  }
}
