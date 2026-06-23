import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/model/onboarding_item.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  static const _initialPage = 1000;
  static const _autoScrollDelay = Duration(seconds: 3);
  static const _scrollDuration = Duration(milliseconds: 520);

  final currentPage = 0.obs;
  final isLoading = true.obs;
  final onboardingData = <OnboardingItem>[].obs;
  final PageController pageController = PageController(
    initialPage: _initialPage,
  );

  Timer? _timer;
  int _pageIndex = _initialPage;

  @override
  void onInit() {
    super.onInit();
    loadOnboardingData();
  }

  void loadOnboardingData() {
    isLoading(true);

    onboardingData.assignAll(const [
      OnboardingItem(
        title: 'Welcome',
        imagePath: 'assets/images/onboarding1.png',
        description: 'Track everything in one place.',
      ),
      OnboardingItem(
        title: 'Stay Organized',
        imagePath: 'assets/images/onboarding2.png',
        description: 'Plan your day with ease.',
      ),
      OnboardingItem(
        title: 'Stay Organized',
        imagePath: 'assets/images/onboarding2.png',
        description: 'Plan your day with ease.',
      ),
      OnboardingItem(
        title: 'Stay Organized',
        imagePath: 'assets/images/onboarding2.png',
        description: 'Plan your day with ease.',
      ),
      OnboardingItem(
        title: 'Get Started',
        imagePath: 'assets/images/onboarding3.png',
        description: "You're all set, let's begin!",
      ),
    ]);

    isLoading(false);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer?.cancel();

    _timer = Timer.periodic(_autoScrollDelay, (timer) {
      if (onboardingData.isEmpty || !pageController.hasClients) return;
      _animateToPage(_pageIndex + 1);
    });
  }

  bool get isLastPage => currentPage.value == onboardingData.length - 1;

  int itemIndexAt(int index) => index % onboardingData.length;

  void pauseAutoScroll() {
    _timer?.cancel();
    _timer = null;
  }

  void restartAutoScroll() {
    pauseAutoScroll();
    _startAutoScroll();
  }

  void onPageChanged(int index) {
    _pageIndex = index;
    currentPage.value = itemIndexAt(index);
  }

  void previousPage() {
    pauseAutoScroll();
    _animateToPage(_pageIndex - 1);
    restartAutoScroll();
  }

  void nextPage() {
    if (isLastPage) {
      goToLogin();
      return;
    }

    pauseAutoScroll();
    _animateToPage(_pageIndex + 1);
    restartAutoScroll();
  }

  void goToLogin() {
    _timer?.cancel();
    Get.offAllNamed('/login');
  }

  void _animateToPage(int page) {
    pageController.animateToPage(
      page,
      duration: _scrollDuration,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void onClose() {
    _timer?.cancel();
    pageController.dispose();
    super.onClose();
  }
}
