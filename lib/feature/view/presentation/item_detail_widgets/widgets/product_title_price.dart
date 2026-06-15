import 'package:flutter/material.dart';

class ProductTitleAndPrice extends StatelessWidget {
  final String? name;
  final String price;

  const ProductTitleAndPrice({
    super.key, 
    this.name, 
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            name ?? 'Unknown watch',
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
          ),
        ),
        Text(
          price,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}