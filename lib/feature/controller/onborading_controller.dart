import 'dart:async'; // Required for Timer
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  var isLoading = true.obs;
  var onboardingData = [].obs;
  final PageController pageController = PageController();

  // Timer for auto-scrolling
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    loadOnboardingData();
  }

  void loadOnboardingData() {
    isLoading(true);

    // Static onboarding data instead of fetching from the API
    onboardingData.value = [
      {
        'title': 'Welcome',
        'image': 'assets/images/onboarding1.png',
        'description': 'Track everything in one place.'
      },
      {
        'title': 'Stay Organized',
        'image': 'assets/images/onboarding1.png',
        'description': 'Plan your day with ease.'
      },
      {
        'title': 'Get Started',
        'image': 'assets/images/onboarding1.png',
        'description': "You're all set, let's begin!"
      },
    ];

    isLoading(false);

    // Start auto-scroll after data is loaded
    _startAutoScroll();
  }

  void _startAutoScroll() {
    // Cancel any existing timer before starting a new one
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (onboardingData.isEmpty) return;

      int nextIndex = currentPage.value + 1;
      if (nextIndex < onboardingData.length) {
        pageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      } else {
        // Loop back to the first page
        pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void onPageChanged(int index) => currentPage.value = index;

  @override
  void onClose() {
    _timer?.cancel(); // Prevents memory leaks
    pageController.dispose();
    super.onClose();
  }
}
