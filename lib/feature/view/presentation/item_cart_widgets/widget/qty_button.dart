import 'package:flutter/material.dart';

class QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final ColorScheme scheme;

  const QtyButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.scheme,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      // Removed 'const' expression identifier so compile-time dynamic parameters render cleanly.
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