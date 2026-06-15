import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/view/presentation/item_detail_widgets/widgets/item_detial.dart';

class ProductRatingTag extends StatelessWidget {
  final String collectionName;

  const ProductRatingTag({
    super.key, 
    required this.collectionName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F1FF),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: const [
              Icon(Icons.star, size: 16, color: ItemDetail.primaryColor),
              SizedBox(width: 8),
              Text(
                '4.9',
                style: TextStyle(color: ItemDetail.primaryColor, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Text(
          collectionName,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        ),
      ],
    );
  }
}