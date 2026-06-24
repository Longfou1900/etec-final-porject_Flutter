import 'dart:math';

import 'package:flutter_projects_getx/feature/controller/cart_controller.dart';
import 'package:get/get.dart';

enum PaymentMethod { card, paypal, cod }

enum OrderStatus { pending, processing, shipped, outForDelivery, delivered }

class CheckoutController extends GetxController {
  final CartController cart = Get.find<CartController>();

  final method = PaymentMethod.card.obs;
  final isPlacingOrder = false.obs;

  // In a real app these would come from user profile / address book.

  // Simulated estimated delivery.
  String get estimatedDeliveryText {
    // Random but deterministic-ish for UI.
    final now = DateTime.now();
    final days = (now.day % 4) + 2; // 2..5
    return '$days - $days+1 days';
  }

  String get totalPriceText => cart.totalPriceText;

  void setMethod(PaymentMethod value) {
    method.value = value;
  }

  Future<void> confirmPayment() async {
    if (cart.items.isEmpty) {
      Get.snackbar('Cart is empty', 'Add items to checkout.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (isPlacingOrder.value) return;

    isPlacingOrder.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 850));

    // Create a fake tracking id
    final rand = Random();
    // Create a fake tracking id (not used when skipping delivery screen)
    rand.nextInt(999);

    // clear cart and route to Home (do not open delivery/tracking screen)
    // clear cart and route to tracking
    isPlacingOrder.value = false;
    cart.clear();
    isPlacingOrder.value = false;

    // Navigate back to Home (no delivery/tracking page)
    Get.offAllNamed('/home');
    Get.snackbar('Payment successful', 'Order placed successfully.');
  }
}
