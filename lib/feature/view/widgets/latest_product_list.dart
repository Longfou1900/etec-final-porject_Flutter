import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/view/presentation/item_detail_widgets/widgets/item_detial.dart';
import 'package:flutter_projects_getx/feature/model/home_model.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class LatestProductList extends StatelessWidget {
  final List<Late>? products;

  const LatestProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: List.generate(products?.length ?? 0, (index) {
        final item = products?[index];
        final price = item?.displayPrice ?? r'$0';

        // Safely bypass compiler type restrictions dynamically 
        final dynamicItemId = (item as dynamic)?.id ?? (item as dynamic)?.productId ?? index;
        final heroTag = 'latest_product_$dynamicItemId';

        return GestureDetector(
          onTap: () {
            Get.to(
              () => ItemDetail(
                id: dynamicItemId is int ? dynamicItemId : 1, 
                index: index, 
                heroTag: heroTag,
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              // Matches the custom slate background from the screenshot reference
              color: scheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(20),
              // Clean border layout matching the screenshot style completely
              border: Border.all(
                color: scheme.surfaceContainerHighest,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Left Image Viewport Frame
                Container(
                  width: 110,
                  height: 120,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.black.withValues(alpha: 0.15) : scheme.surface,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Hero(
                    tag: heroTag,
                    child: Image.network(
                      item?.images ?? '',
                      fit: BoxFit.contain, // Prevents cropping or stretching watch frames
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.watch_rounded,
                        size: 32,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                
                // Right Detail Info Segment
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 12, 16, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item?.name ?? 'Unknown',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Minimal, comfortable, and designed for everyday wear.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 12,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        
                        // Rating Pill and Pricing Row
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                // Adapts nicely from dark tint opacity to royal blue accents
                                color: scheme.secondary.withValues(alpha: isDark ? 0.12 : 0.08),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    size: 13,
                                    color: isDark ? scheme.secondary : const Color(0xFF2563EB),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '4.8',
                                    style: TextStyle(
                                      color: isDark ? scheme.secondary : const Color(0xFF2563EB),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Text(
                              price,
                              style: TextStyle(
                                color: scheme.onSurface,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}