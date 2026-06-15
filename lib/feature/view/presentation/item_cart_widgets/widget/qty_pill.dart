import 'package:flutter/material.dart';

class QtyPill extends StatelessWidget {
  final int qty;
  final ColorScheme scheme;

  const QtyPill({
    super.key, 
    required this.qty, 
    required this.scheme,
  });

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