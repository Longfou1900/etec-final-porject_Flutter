import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_projects_getx/core/auth/auth_theme.dart';
import 'package:flutter_projects_getx/feature/controller/onborading_controller.dart';
import 'package:flutter_projects_getx/feature/view/screen/onborading/widgets/onboarding_controls.dart';
import 'package:flutter_projects_getx/feature/view/screen/onborading/widgets/onboarding_page.dart';
import 'package:flutter_projects_getx/feature/view/screen/onborading/widgets/onboarding_page_style.dart';
import 'package:flutter_projects_getx/feature/view/screen/onborading/widgets/smooth_fade_in.dart';
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
      backgroundColor: AuthTheme.background,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const _LoadingView();
        }

        return Stack(
          children: [
            const _SplashLikeBackground(),
            const _SoftBlobs(),
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

                  return _PageRevealAnimation(
                    key: ValueKey(itemIndex),
                    controller: controller,
                    pageIndex: itemIndex,
                    child: OnboardingPage(
                      item: controller.onboardingData[itemIndex],
                      style: OnboardingPageStyle.at(itemIndex),
                    ),
                  );
                },
              ),
            ),
            // brand header removed (splash-like scroll animations only)
            OnboardingControls(controller: controller),
          ],
        );
      }),
    );
  }
}

class _PageRevealAnimation extends StatelessWidget {
  final OnboardingController controller;
  final int pageIndex;
  final Widget child;

  const _PageRevealAnimation({
    required this.controller,
    required this.pageIndex,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isActive = controller.currentPage.value == pageIndex;

      return SmoothFadeIn(
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 420),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()
            ..translate(0.0, isActive ? 0.0 : 12.0)
            ..scale(isActive ? 1.0 : 0.985),
          child: child,
        ),
      );
    });
  }
}

@Deprecated('Brand header removed; keep class only if needed later.')
class _BrandHeader extends StatelessWidget {
  const _BrandHeader();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 0,
      right: 0,
      child: SafeArea(
        bottom: false,
        child: Center(
          child: SmoothFadeIn(
            duration: const Duration(milliseconds: 520),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.62),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: AuthTheme.primaryDark.withOpacity(0.12),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AuthTheme.primaryDark.withOpacity(0.12),
                    ),
                    child: Icon(
                      Icons.watch_rounded,
                      size: 18,
                      color: AuthTheme.primaryDark,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Argumind',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF272735),
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SplashLikeBackground extends StatelessWidget {
  const _SplashLikeBackground();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF6F7FF),
              Color(0xFFEFF3FF),
              Color(0xFFFFFFFF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}

class _SoftBlobs extends StatelessWidget {
  const _SoftBlobs();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          _CircleBlob(
            alignment: const Alignment(1.2, -0.95),
            size: 320,
            opacity: 0.10,
          ),
          _CircleBlob(
            alignment: const Alignment(1.1, 0.05),
            size: 240,
            opacity: 0.06,
          ),
          _CircleBlob(
            alignment: const Alignment(-1.1, 0.55),
            size: 360,
            opacity: 0.10,
          ),
          _CircleBlob(
            alignment: const Alignment(-1.15, -0.05),
            size: 220,
            opacity: 0.06,
          ),
          // subtle rotated rectangle like the old card vibe
          Positioned(
            top: -80,
            left: -120,
            child: Transform.rotate(
              angle: -0.78,
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  color: AuthTheme.primaryDark.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(42),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleBlob extends StatelessWidget {
  final Alignment alignment;
  final double size;
  final double opacity;

  const _CircleBlob({
    required this.alignment,
    required this.size,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Transform.rotate(
        angle: (alignment.x + alignment.y) * 0.04,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AuthTheme.primaryDark.withOpacity(opacity),
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
      color: Color(0xFFEEF1FF),
      child: Center(
        child: CircularProgressIndicator(
          color: Color(0xFF272735),
          strokeWidth: 2.4,
        ),
      ),
    );
  }
}
