import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/view/presentation/item_detail_widgets/widgets/action_button.dart';
import 'package:flutter_projects_getx/feature/view/presentation/item_detail_widgets/widgets/detail_header.dart';
import 'package:flutter_projects_getx/feature/view/presentation/item_detail_widgets/widgets/product_feature_list.dart';
import 'package:flutter_projects_getx/feature/view/presentation/item_detail_widgets/widgets/product_hero_image.dart';
import 'package:flutter_projects_getx/feature/view/presentation/item_detail_widgets/widgets/product_overview.dart';
import 'package:flutter_projects_getx/feature/view/presentation/item_detail_widgets/widgets/product_rating_tag.dart';
import 'package:flutter_projects_getx/feature/view/presentation/item_detail_widgets/widgets/product_title_price.dart';
import 'package:get/get.dart';
import 'package:flutter_projects_getx/feature/controller/cart_controller.dart';
import 'package:flutter_projects_getx/feature/controller/home_controller.dart';

class ItemDetail extends StatelessWidget {
  final int id;
  final int index;
  final String heroTag;

  const ItemDetail({
    super.key,
    required this.id,
    required this.index,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final homeController = Get.find<HomeController>();
    final cartController = Get.find<CartController>();

    final item = _resolveItem(homeController);
    final price = item?.displayPrice ?? r'$0';
    final collectionName = id == 0 ? 'Popular Collection' : 'Latest Collection';

    return Scaffold(
      // Seamlessly dynamically maps to our premium Light / Dark theme configurations
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Fixed high-end persistent navigation bar
            const DetailHeader(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Modern Immersive Hero Stage Container Window (Large Variant)
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      height: MediaQuery.sizeOf(context).height *
                          0.42, // Expanded viewport for high-impact display
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: scheme.surfaceContainerHighest,
                          width: 1,
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Luxury-tier deep drop-shadow ground effect
                          Positioned(
                            bottom: 32,
                            child: Container(
                              width: 180,
                              height: 16,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: scheme.onSurface
                                        .withValues(alpha: isDark ? 0.3 : 0.06),
                                    blurRadius: 28,
                                    spreadRadius: 6,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // The large uncropped item display asset logic
                          ProductHeroImage(
                            heroTag: heroTag,
                            imageUrl: item?.images,
                            images: [],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Technical Specifications Details Canvas Sheet
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductTitleAndPrice(name: item?.name, price: price),
                          const SizedBox(height: 14),

                          ProductRatingTag(collectionName: collectionName),
                          const SizedBox(height: 20),

                          // Fine modern structural horizontal dividing boundary rule
                          Divider(
                              color: scheme.surfaceContainerHighest, height: 1),
                          const SizedBox(height: 20),

                          ProductOverview(description: item?.description),
                          const SizedBox(height: 24),

                          const ProductFeaturesList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Sticky Bottom Interactive Purchase Drawer Control Deck
            Container(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
              decoration: BoxDecoration(
                color: scheme.surface,
                border: Border(
                  top: BorderSide(
                    color: scheme.surfaceContainerHighest,
                    width: 1,
                  ),
                ),
              ),
              child: ActionButtons(
                onWishlistPressed: () {},
                onAddToCartPressed: item == null
                    ? null
                    : () => _handleAddToCart(cartController, item, scheme),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Extracts the context safe model layer data dynamically via the HomeController
  dynamic _resolveItem(HomeController controller) {
    final data = controller.homeModel.data;
    if (id == 0) {
      return data?.popular != null && index < data!.popular!.length
          ? data.popular![index]
          : null;
    } else {
      return data?.lates != null && index < data!.lates!.length
          ? data.lates![index]
          : null;
    }
  }

  /// Triggers internal Cart Controller state pipeline updates and prints validation snackbars
  void _handleAddToCart(
      CartController cartController, dynamic item, ColorScheme scheme) {
    final productId = '${id}_$index';
    cartController.addToCart(
      productId: productId,
      name: item.name ?? 'Unknown watch',
      image: item.images ?? '',
      priceText: (item.displayPrice).toString(),
      qty: 1,
    );

    // Premium Floating Context Micro Feedback Alert Window
    Get.snackbar(
      'Cart Updated',
      '${item.name ?? 'Item'} added successfully.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: scheme.primary,
      colorText: scheme.onPrimary,
      margin: const EdgeInsets.all(16),
      borderRadius: 14,
      duration: const Duration(milliseconds: 1500),
      boxShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 12,
          offset: const Offset(0, 4),
        )
      ],
    );
  }
}
