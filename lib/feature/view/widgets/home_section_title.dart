import 'package:flutter/material.dart';

class HomeSectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const HomeSectionTitle(this.title, this.subtitle, {super.key});

  @override
  Widget build(BuildContext context) {
    // Access the current color scheme based on the active theme
    final scheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color:
                    scheme.onSurface, // Automatically adapts to Light/Dark mode
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: TextStyle(
                color: scheme.onSurfaceVariant, // A softer tone for subtitles
                fontSize: 14,
              ),
            ),
          ],
        ),
        Text(
          'See all',
          style: TextStyle(
            color: scheme
                .primary, // Highlights "See all" with your theme's primary color
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
