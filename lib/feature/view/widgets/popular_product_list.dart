import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/view/presentation/item_detail_widgets/widgets/item_detial.dart';
import 'package:flutter_projects_getx/feature/model/home_model.dart';
import 'package:get/get.dart';

class PopularProductList extends StatelessWidget {
  final List<Late>? products;

  const PopularProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return SizedBox(
      height: 290, 
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: products?.length ?? 0,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = products?[index];
          final price = item?.displayPrice ?? r'$0';
          
          // Bypasses model visibility conflicts safely using a dynamic compiler check
          final dynamicItemId = (item as dynamic)?.id ?? (item as dynamic)?.productId ?? index;
          final heroTag = 'popular_product_$dynamicItemId';

          return GestureDetector(
            onTap: () {
              Get.to(
                () => ItemDetail(
                  id: dynamicItemId is int ? dynamicItemId : 0,
                  index: index,
                  heroTag: heroTag,
                ),
              );
            },
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                // Uses the exact dark-surface color from your image
                color: scheme.surfaceContainerLow, 
                borderRadius: BorderRadius.circular(20),
                // Premium thin hairline border matching the screenshot style completely
                border: Border.all(
                  color: scheme.surfaceContainerHighest,
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Image Viewport Frame
                    Expanded(
                      flex: 11,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            // Slightly darker tint behind the item showcase
                            color: Colors.black.withValues(alpha: 0.15),
                            padding: const EdgeInsets.all(16),
                            child: Hero(
                              tag: heroTag,
                              child: Image.network(
                                item?.images ?? '',
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => Icon(
                                  Icons.watch_rounded,
                                  size: 40,
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ),
                          // Minimal Accent Label Tag
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: scheme.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'POPULAR',
                                style: TextStyle(
                                  color: scheme.primary,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Divider Line between image and info text
                    Container(height: 1, color: scheme.surfaceContainerHighest),

                    // 2. Info Details Panel
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item?.name ?? 'Premium Watch',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Luxury automatic watch',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            
                            // Bottom row: Pricing text & minimalist icon container shape
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  price,
                                  style: TextStyle(
                                    color: scheme.onSurface,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: scheme.surfaceContainerHighest,
                                      width: 1,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 14,
                                    color: scheme.onSurface,
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
            ),
          );
        },
      ),
    );
  }
}