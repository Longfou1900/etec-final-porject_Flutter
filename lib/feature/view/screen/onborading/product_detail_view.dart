import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/controller/product_detail_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    Get.put(ProductDetailController());

    return Scaffold(
      backgroundColor: const Color(0xFF3D5AFE),
      body: Obx(() {
        // Handle loading state first
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: Colors.white));
        }

        // Return the UI only when data is loaded
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              // Use controller.product.value inside the Text widget
              Text(
                controller.product['title'] ?? "No Title",
                style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    controller.product['description'] ?? "",
                    style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}