import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/checkout_controller.dart';
import 'widgets/checkout/checkout_card.dart';
import 'widgets/checkout/payment_method_tile.dart';
import 'widgets/checkout/delivery_summary_tile.dart';
import 'widgets/checkout/checkout_footer.dart';
import 'widgets/checkout/stepper_header.dart';
import 'widgets/checkout/form_field_tile.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CheckoutController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(
          () {
            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              children: [
                const StepperHeader(),
                const SizedBox(height: 14),
                CheckoutCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Payment method',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 10),
                      PaymentMethodTile(
                        title: 'Credit / Debit Card',
                        subtitle: 'Visa, MasterCard',
                        value: PaymentMethod.card,
                        groupValue: controller.method.value,
                        onChanged: controller.setMethod,
                      ),
                      PaymentMethodTile(
                        title: 'PayPal',
                        subtitle: 'Fast and secure',
                        value: PaymentMethod.paypal,
                        groupValue: controller.method.value,
                        onChanged: controller.setMethod,
                      ),
                      PaymentMethodTile(
                        title: 'Cash on Delivery',
                        subtitle: 'Pay when delivered',
                        value: PaymentMethod.cod,
                        groupValue: controller.method.value,
                        onChanged: controller.setMethod,
                      ),
                      const SizedBox(height: 12),
                      if (controller.method.value == PaymentMethod.card) ...[
                        const SizedBox(height: 2),
                        const FormFieldTile(
                          label: 'Card number',
                          hint: '1234 5678 9012 3456',
                          isObscure: false,
                        ),
                        const SizedBox(height: 10),
                        const FormFieldTile(
                          label: 'Expiry',
                          hint: 'MM/YY',
                          isObscure: false,
                        ),
                        const SizedBox(height: 10),
                        const FormFieldTile(
                          label: 'CVV',
                          hint: '***',
                          isObscure: true,
                        ),
                        const SizedBox(height: 8),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                CheckoutCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Delivery',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 10),
                      const DeliverySummaryTile(
                        icon: Icons.location_on_outlined,
                        title: 'Delivery address',
                        subtitle: '221B Baker Street, London',
                      ),
                      const SizedBox(height: 10),
                      DeliverySummaryTile(
                        icon: Icons.access_time_outlined,
                        title: 'Estimated time',
                        subtitle: controller.estimatedDeliveryText,
                      ),
                      const SizedBox(height: 2),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                CheckoutFooter(
                  totalText: controller.totalPriceText,
                  isLoading: controller.isPlacingOrder.value,
                ),
                const SizedBox(height: 6),
              ],
            );
          },
        ),
      ),
    );
  }
}
