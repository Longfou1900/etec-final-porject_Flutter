import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/model/home_model.dart';

class PromoSlide extends StatelessWidget {
  final Late item;

  const PromoSlide({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 160, // Fixed height ensures predictable layout alignment inside carousels
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24), // Modern deep-radius corners
        border: Border.all(
          color: scheme.surfaceContainerHighest,
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // 1. Decorative Light Radial Blur Ambient Background
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: scheme.primary.withValues(alpha: isDark ? 0.06 : 0.03),
                ),
              ),
            ),

            // 2. Main Content Row Split
            Row(
              children: [
                // Left Text Column
                Expanded(
                  flex: 55,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 8, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Pill Tag
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: scheme.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'SUPER SALE',
                            style: TextStyle(
                              color: scheme.primary,
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        
                        // Product Title
                        Text(
                          item.name ?? 'Premium Edition',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 6),
                        
                        // Price & CTA Row aligned seamlessly
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              item.displayPrice,
                              style: TextStyle(
                                color: scheme.primary, // Highlights pricing dynamically
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              width: 3,
                              height: 3,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: scheme.onSurfaceVariant.withValues(alpha: 0.4),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Limited Offer',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: scheme.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Right Image Canvas
                Expanded(
                  flex: 45,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Elevated inner container framing behind the item asset
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
                            width: 1,
                          ),
                        ),
                      ),
                      
                      // Intersecting floating product presentation layer
                      Transform.rotate(
                        angle: -0.12, // Distinct angled turn used in luxury brand product layouts
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.network(
                            item.images ?? '',
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => Icon(
                              Icons.watch_rounded,
                              size: 44,
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // 3. Subtle Interactive Edge Border overlay
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: isDark ? 0.03 : 0.0),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}