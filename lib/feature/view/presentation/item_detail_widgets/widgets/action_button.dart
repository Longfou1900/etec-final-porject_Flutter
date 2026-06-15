import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/view/presentation/item_detail_widgets/widgets/item_detial.dart';


class ActionButtons extends StatelessWidget {
  final VoidCallback onWishlistPressed;
  final VoidCallback? onAddToCartPressed;

  const ActionButtons({
    super.key,
    required this.onWishlistPressed,
    required this.onAddToCartPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onWishlistPressed,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: ItemDetail.primaryColor),
              shape: RoundedRectangleBorder(borderRadius: ItemDetail.borderRadiusMedium),
              padding: const EdgeInsets.symmetric(vertical: 18),
            ),
            child: const Text(
              'Wishlist',
              style: TextStyle(color: ItemDetail.primaryColor, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: onAddToCartPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: ItemDetail.primaryColor,
              shape: RoundedRectangleBorder(borderRadius: ItemDetail.borderRadiusMedium),
              padding: const EdgeInsets.symmetric(vertical: 18),
            ),
            child: const Text(
              'Add to Cart',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}