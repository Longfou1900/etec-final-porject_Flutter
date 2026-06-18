import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/view/presentation/item_cart_widgets/widget/cart_header.dart';
import 'package:flutter_projects_getx/feature/view/presentation/item_cart_widgets/widget/cart_row.dart';
import 'package:flutter_projects_getx/feature/view/presentation/item_cart_widgets/widget/checkout_bar.dart';
import 'package:flutter_projects_getx/feature/view/presentation/item_cart_widgets/widget/empty_cart.dart';
import 'package:get/get.dart';
import 'package:flutter_projects_getx/feature/controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartController>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            CartHeader(cart: cart),
            Expanded(
              child: Obx(() {
                if (cart.items.isEmpty) {
                  return EmptyCart(theme: Theme.of(context));
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: cart.items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return CartRow(
                      item: item,
                      onInc: () => cart.increment(item.productId),
                      onDec: () => cart.decrement(item.productId),
                      onRemove: () => cart.remove(item.productId),
                    );
                  },
                );
              }),
            ),
            CheckoutBar(cart: cart),
          ],
        ),
      ),
    );
  }
}