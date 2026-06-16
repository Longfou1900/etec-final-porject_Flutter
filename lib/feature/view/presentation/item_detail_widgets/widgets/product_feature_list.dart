import 'package:flutter/material.dart';

class ProductFeaturesList extends StatelessWidget {
  const ProductFeaturesList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Features',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 14),
        _buildFeatureTile(context, Icons.watch_rounded, 'Stainless steel finish'),
        const SizedBox(height: 12),
        _buildFeatureTile(context, Icons.bolt_rounded, 'Automatic movement'),
        const SizedBox(height: 12),
        _buildFeatureTile(context, Icons.water_drop_rounded, 'Water resistant 50m'),
      ],
    );
  }

  Widget _buildFeatureTile(BuildContext context, IconData icon, String text) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: scheme.surfaceContainerHighest, width: 1),
          ),
          child: Icon(icon, size: 20, color: scheme.onSurface),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}