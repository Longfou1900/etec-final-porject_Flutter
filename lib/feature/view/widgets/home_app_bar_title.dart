import 'package:flutter/material.dart';

class HomeAppBarTitle extends StatelessWidget {
  const HomeAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the current theme and colorScheme directly from context
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // We use a getter or local variable to maintain consistency
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Watch ETEC',
          style: TextStyle(
            // Use theme colors for better support of Light/Dark modes
            color: isDark ? scheme.onSurface : scheme.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Premium watches',
          style: TextStyle(
            // Use onSurfaceVariant or opacity for secondary text
            color: scheme.onSurfaceVariant.withValues(alpha: 0.7),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
