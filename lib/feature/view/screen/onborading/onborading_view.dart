import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_projects_getx/feature/controller/onborading_controller.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  // Define brand colors
  static const Color brandCharcoal = Color(0xFF2D3436);
  static const Color brandLimeGreen = Color(0xFF00FF88);
  static const Color brandNeutralBg = Colors.white;

  @override
  Widget build(BuildContext context) {
    final OnboardingController controller = Get.put(OnboardingController());

    return Scaffold(
      backgroundColor: brandNeutralBg,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(color: brandCharcoal));
        }

        return SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  itemCount: controller.onboardingData.length,
                  itemBuilder: (context, index) {
                    final item = controller.onboardingData[index];
                    return _buildPageContent(
                      item['title']?.toString() ?? "",
                      item['image']?.toString() ?? "",
                      item['description']?.toString() ?? "",
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // Pagination Dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        controller.onboardingData.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.currentPage.value == index
                                ? brandLimeGreen
                                : Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Action Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: brandCharcoal,
                        foregroundColor: brandNeutralBg,
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () => controller.currentPage.value ==
                              controller.onboardingData.length - 1
                          ? Get.offAllNamed('/login')
                          : controller.pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease),
                      child: const Text("Next", style: TextStyle(fontSize: 18)),
                    ),
                    TextButton(
                      onPressed: () => Get.offAllNamed('/login'),
                      child: const Text("Skip",
                          style: TextStyle(color: Colors.grey)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildPageContent(String title, String imagePath, String subtitle) {
    final bool hasValidImage = imagePath.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: !hasValidImage
                ? const Icon(Icons.image_not_supported,
                    size: 100, color: Colors.black)
                : Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      debugPrint('Error loading asset at $imagePath: $error');
                      return const Icon(Icons.broken_image,
                          size: 80, color: Colors.red);
                    },
                  ),
          ),
          const SizedBox(height: 40),
          Text(title,
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(subtitle, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
