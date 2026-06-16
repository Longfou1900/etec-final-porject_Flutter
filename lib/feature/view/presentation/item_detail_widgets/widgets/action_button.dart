import 'package:flutter/material.dart';

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
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Row(
      children: [
        // Premium minimal stroke layout icon option
        IconButton(
          onPressed: onWishlistPressed,
          icon: const Icon(Icons.favorite_border_rounded),
          style: IconButton.styleFrom(
            foregroundColor: scheme.onSurface,
            backgroundColor: scheme.surfaceContainerLow,
            side: BorderSide(color: scheme.surfaceContainerHighest, width: 1),
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
        const SizedBox(width: 12),
        
        // Main structural interaction trigger block
        Expanded(
          child: ElevatedButton(
            onPressed: onAddToCartPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: scheme.primary,
              foregroundColor: scheme.onPrimary,
              elevation: 0,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.symmetric(vertical: 18),
            ),
            child: const Text(
              'Add to Cart',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, letterSpacing: -0.1),
            ),
          ),
        ),
      ],
    );
  }
}