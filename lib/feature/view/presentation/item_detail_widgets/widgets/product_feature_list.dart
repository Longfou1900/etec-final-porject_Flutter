import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/view/presentation/item_detail_widgets/widgets/item_detial.dart';

class ProductFeaturesList extends StatelessWidget {
  const ProductFeaturesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Features',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 14),
        _buildFeatureTile(Icons.watch, 'Stainless steel finish'),
        const SizedBox(height: 12),
        _buildFeatureTile(Icons.bolt, 'Automatic movement'),
        const SizedBox(height: 12),
        _buildFeatureTile(Icons.water_drop, 'Water resistant'),
      ],
    );
  }

  Widget _buildFeatureTile(IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F6FF),
            borderRadius: BorderRadius.circular(14),
          ),
          // REMOVED 'const' from here because 'icon' is dynamic
          child: Icon(icon, size: 18, color: ItemDetail.primaryColor),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}