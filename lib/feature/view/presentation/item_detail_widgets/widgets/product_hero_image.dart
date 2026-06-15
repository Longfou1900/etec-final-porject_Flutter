import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/view/presentation/item_detail_widgets/widgets/item_detial.dart';

class ProductHeroImage extends StatelessWidget {
  final String heroTag;
  final String? imageUrl;

  const ProductHeroImage({
    super.key, 
    required this.heroTag, 
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: ClipRRect(
        borderRadius: ItemDetail.borderRadiusLarge,
        child: Image.network(
          imageUrl ?? '',
          height: 320,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            height: 320,
            color: Colors.grey.shade300,
            child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}