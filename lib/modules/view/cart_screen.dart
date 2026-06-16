import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/modules/controller/cart_controller.dart';
import 'package:flutter_projects_getx/modules/model/cart_item.dart';
import 'package:get/get.dart';

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
            _CartHeader(cart: cart),
            Expanded(
              child: Obx(() {
                if (cart.items.isEmpty) {
                  return _EmptyCart(theme: Theme.of(context));
                }

                return ListView.separated(
                  padding:  EdgeInsets.symmetric(horizontal: 16),
                  itemCount: cart.items.length,
                  separatorBuilder: (context, i) =>  SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return _CartRow(
                      item: item,
                      onInc: () => cart.increment(item.productId),
                      onDec: () => cart.decrement(item.productId),
                      onRemove: () => cart.remove(item.productId),
                    );
                  },
                );
              }),
            ),
            _CheckoutBar(cart: cart),
          ],
        ),
      ),
    );
  }
}

class _CartHeader extends StatelessWidget {
  final CartController cart;
   const _CartHeader({required this.cart});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => Get.back(),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 14,
                    offset:  Offset(0, 8),
                  )
                ],
              ),
              child:  Icon(Icons.arrow_back_ios_new, size: 18),
            ),
          ),
           SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  'Cart',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.3,
                  ),
                ),
                Obx(() => Text(
                      '${cart.items.length} item${cart.items.length == 1 ? '' : 's'}',
                      style: TextStyle(
                        color: scheme.onSurface.withValues(alpha: 0.65),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ],
            ),
          ),
          Obx(() => cart.items.isEmpty
              ?  SizedBox(width: 44)
              : InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => cart.clear(),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child:  Icon(Icons.delete_outline, size: 20),
                  ),
                )),
        ],
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  final ThemeData theme;
  const _EmptyCart({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 92,
              height: 92,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(26),
              ),
              child:  Icon(Icons.shopping_bag_outlined, size: 36),
            ),
             SizedBox(height: 18),
            Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: theme.colorScheme.onSurface,
              ),
            ),
             SizedBox(height: 10),
            Text(
              'Tap “Add to Cart” on a product to get started.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartRow extends StatelessWidget {
  final CartItem item;
  final VoidCallback onInc;
  final VoidCallback onDec;
  final VoidCallback onRemove;

    const _CartRow({
    required this.item,
    required this.onInc,
    required this.onDec,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 18,
              offset:  Offset(0, 10),
            )
          ],
        ),
        padding:  EdgeInsets.all(14),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                item.image,
                width: 66,
                height: 66,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) =>  SizedBox.shrink(),
              ),
            ),
             SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: scheme.onSurface,
                    ),
                  ),
                   SizedBox(height: 6),
                  Text(
                    'Price: ${item.priceText}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: scheme.onSurface.withValues(alpha: 0.65),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 42,
                    // iPhone-like horizontal scroll controls
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Row(
                          children: [
                            _QtyButton(
                              icon: Icons.remove,
                              onTap: onDec,
                              scheme: scheme,
                            ),
                            _QtyPill(qty: item.qty, scheme: scheme),
                            _QtyButton(
                              icon: Icons.add,
                              onTap: onInc,
                              scheme: scheme,
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        // Delete area to the right; scroll reveals it.
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.red.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: onRemove,
                                child: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  item.priceText,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: scheme.onSurface,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'x${item.qty}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: scheme.onSurface.withValues(alpha: 0.55),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final ColorScheme scheme;


  const _QtyButton({
    required this.icon,
    required this.onTap,
    required this.scheme,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: scheme.onSurface.withValues(alpha: 0.10),
          ),
        ),
        child: Icon(icon, size: 18, color: scheme.onSurface),
      ),
    );
  }
}

class _QtyPill extends StatelessWidget {
  final int qty;
  final ColorScheme scheme;

  const _QtyPill({required this.qty, required this.scheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 42,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14),
      ),
      alignment: Alignment.center,
      child: Text(
        '$qty',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: scheme.primary,
        ),
      ),
    );
  }
}

class _CheckoutBar extends StatelessWidget {
  final CartController cart;
  const _CheckoutBar({required this.cart});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Obx(() {
      return Padding(
        padding:  EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Container(
          padding:  EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 18,
                offset:  Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),
                    Text(
                      cart.totalPriceText,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: scheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: cart.items.isEmpty ? null : () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: scheme.primary,
                  padding:
                       EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child:  Text(
                  'Checkout',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
