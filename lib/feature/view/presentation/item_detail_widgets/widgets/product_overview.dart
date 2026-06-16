import 'package:flutter/material.dart';

class ProductOverview extends StatelessWidget {
  final String? description;

  const ProductOverview({
    super.key, 
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    const fallbackDescription =
        'A premium watch with a modern silhouette, sharp detailing, and a refined finish built for everyday luxury.';
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overview',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        Text(
          (description != null && description!.isNotEmpty) ? description! : fallbackDescription,
          style: TextStyle(color: Colors.grey.shade700, fontSize: 15, height: 1.6),
        ),
      ],
    );
  }
}