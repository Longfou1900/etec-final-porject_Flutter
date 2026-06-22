import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/controller/onborading_controller.dart';
import 'package:flutter_projects_getx/feature/view/screen/onborading/widgets/onboarding_page_style.dart';
import 'package:flutter_projects_getx/feature/view/screen/onborading/widgets/page_indicator.dart';
import 'package:get/get.dart';

class OnboardingControls extends StatelessWidget {
  final OnboardingController controller;

  const OnboardingControls({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final current = controller.currentPage.value;
      final style = OnboardingPageStyle.at(current);

      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(44, 48, 44, 62),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: _SkipButton(onPressed: controller.goToLogin),
              ),
              const Spacer(),
              _BottomActions(
                current: current,
                total: controller.onboardingData.length,
                isLastPage: controller.isLastPage,
                accentColor: style.accent,
                onNext: controller.nextPage,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _SkipButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SkipButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF272735),
        backgroundColor: Colors.white.withValues(alpha: 0.82),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      child: const Text(
        'Skip',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  final int current;
  final int total;
  final bool isLastPage;
  final Color accentColor;
  final VoidCallback onNext;

  const _BottomActions({
    required this.current,
    required this.total,
    required this.isLastPage,
    required this.accentColor,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onNext,
          borderRadius: BorderRadius.circular(36),
          child: Container(
            width: 62,
            height: 62,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: accentColor, width: 2),
            ),
            child: const DecoratedBox(
              decoration: BoxDecoration(
                color: Color(0xFF020207),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        PageIndicator(total: total, current: current),
      ],
    );
  }
}
