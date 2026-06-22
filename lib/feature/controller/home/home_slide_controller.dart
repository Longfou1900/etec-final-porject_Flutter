import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_projects_getx/feature/controller/home/home_controller.dart';
import 'package:flutter_projects_getx/feature/model/home_model.dart';

class HomeSliderController extends GetxController {
  final HomeController _homeController = Get.find<HomeController>();
  
  final PageController pageController = PageController();
  final RxInt currentSlide = 0.obs;
  Timer? _slideTimer;

  List<Late> get slideItems {
    final popularItems = _homeController.homeModel.data?.popular ?? [];
    final latestItems = _homeController.homeModel.data?.lates ?? [];
    return [...popularItems, ...latestItems]
        .where((item) => item.hasValidImage)
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    _startAutoSlider();
  }

  void _startAutoSlider() {
    _slideTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!pageController.hasClients) return;
      
      final totalSlides = slideItems.length;
      if (totalSlides <= 1) return;

      final nextSlide = (currentSlide.value + 1) % totalSlides;
      currentSlide.value = nextSlide;
      
      pageController.animateToPage(
        nextSlide,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOut,
      );
    });
  }

  void updateSlideIndex(int index) {
    currentSlide.value = index;
  }

  @override
  void onClose() {
    _slideTimer?.cancel();
    pageController.dispose();
    super.onClose();
  }
}