import 'dart:math';

import 'package:flutter_projects_getx/feature/controller/cart_controller.dart';
import 'package:get/get.dart';

import '../view/screen/tracking_screen/tracking_view.dart';

enum PaymentMethod { card, paypal, cod }

enum OrderStatus { pending, processing, shipped, outForDelivery, delivered }

class CheckoutController extends GetxController {
  final CartController cart = Get.find<CartController>();

  final method = PaymentMethod.card.obs;
  final isPlacingOrder = false.obs;

  // In a real app these would come from user profile / address book.
  final String _trackingIdPrefix = 'TRK';

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
    final id =
        '$_trackingIdPrefix${DateTime.now().millisecondsSinceEpoch}${rand.nextInt(999)}';

    // clear cart and route to tracking
    cart.clear();
    isPlacingOrder.value = false;

    // Use Get.to to navigate. We pass trackingId and initial status.
    Get.to(() => TrackingView(trackingId: id),
        transition: Transition.rightToLeftWithFade);
    Get.snackbar('Payment successful', 'Order placed successfully.');
  }
}
