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
        title: Text('Checkout'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(
          () {
            return ListView(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              children: [
                StepperHeader(),
                SizedBox(height: 14),
                CheckoutCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payment method',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w800),
                      ),
                      SizedBox(height: 10),
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
                      SizedBox(height: 12),
                      if (controller.method.value == PaymentMethod.card) ...[
                        SizedBox(height: 2),
                        FormFieldTile(
                          label: 'Card number',
                          hint: '+855 5678 9012 3456',
                          isObscure: false,
                        ),
                        SizedBox(height: 10),
                        FormFieldTile(
                          label: 'Expiry',
                          hint: 'MM/YY',
                          isObscure: false,
                        ),
                        SizedBox(height: 10),
                        FormFieldTile(
                          label: 'CVV',
                          hint: '***',
                          isObscure: true,
                        ),
                        SizedBox(height: 8),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: 12),
                CheckoutCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Delivery',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w800),
                      ),
                      SizedBox(height: 10),
                      DeliverySummaryTile(
                        icon: Icons.location_on_outlined,
                        title: 'Delivery address',
                        subtitle: '221B Baker Street, Cambodia',
                      ),
                      SizedBox(height: 10),
                      DeliverySummaryTile(
                        icon: Icons.access_time_outlined,
                        title: 'Estimated time',
                        subtitle: controller.estimatedDeliveryText,
                      ),
                      SizedBox(height: 2),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                CheckoutFooter(
                  totalText: controller.totalPriceText,
                  isLoading: controller.isPlacingOrder.value,
                ),
                SizedBox(height: 6),
              ],
            );
          },
        ),
      ),
    );
  }
}
