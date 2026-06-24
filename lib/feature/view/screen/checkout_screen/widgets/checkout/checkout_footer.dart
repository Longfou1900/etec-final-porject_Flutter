import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/checkout_controller.dart';

class CheckoutFooter extends StatelessWidget {
  final String totalText;
  final bool isLoading;

  const CheckoutFooter({
    super.key,
    required this.totalText,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: scheme.primary.withValues(alpha: 0.10),
        border: Border.all(color: scheme.primary.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 4),
                Text(
                  totalText,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: scheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          SizedBox(
            height: 46,
            child: ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      final c = Get.find<CheckoutController>();
                      await c.confirmPayment();
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: scheme.primary,
                padding: EdgeInsets.symmetric(horizontal: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: isLoading
                  ? SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : Text(
                      'Pay & Checkout',
                      style: TextStyle(
                          fontWeight: FontWeight.w900, color: Colors.white),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
