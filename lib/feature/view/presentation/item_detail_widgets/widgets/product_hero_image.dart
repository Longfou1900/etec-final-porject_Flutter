import 'package:flutter/material.dart';

class ProductHeroImage extends StatelessWidget {
  final String heroTag;
  final String? imageUrl;

  const ProductHeroImage({
    super.key, 
    required this.heroTag, 
    this.imageUrl, required List<String> images,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Hero(
      tag: heroTag,
      child: Padding(
        // Reduced padding values from 24 to 8 to give the watch asset maximum breathing room
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity, // Automatically inherits and expands to the 42% screen allocation height
          child: Image.network(
            imageUrl ?? '',
            fit: BoxFit.contain, // Ensures the product layout graphic renders completely uncropped
            alignment: Alignment.center,
            errorBuilder: (_, __, ___) => Icon(
              Icons.watch_rounded, 
              size: 110, // Increased error icon dimension profile
              color: scheme.onSurfaceVariant.withValues(alpha: 0.3),
            ),
          ),
        ),
      ),
    );
  }
}