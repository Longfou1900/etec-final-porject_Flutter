import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  // Use an Rx object to hold the product details
  var product = {}.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Simulate fetching data
    fetchProductDetails();
  }

  void fetchProductDetails() {
    // Replace this with your actual API call
    product.value = {
      "title": "Light Gunmetal Ambassador",
      "description": "The new Light Gunmetal Ambassador is a boldly monochromatic concept..."
    };
    isLoading.value = false;
  }
}