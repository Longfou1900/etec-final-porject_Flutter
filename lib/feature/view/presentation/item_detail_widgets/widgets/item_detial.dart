import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/controller/favorite_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_projects_getx/feature/view/presentation/item_detail_widgets/widgets/product_feature_list.dart';
import 'package:flutter_projects_getx/feature/view/presentation/item_detail_widgets/widgets/product_hero_image.dart';
import 'package:flutter_projects_getx/feature/controller/cart_controller.dart';
import 'package:flutter_projects_getx/feature/controller/home_controller.dart';

class ItemDetail extends StatelessWidget {
  final int id;
  final int index;
  final String heroTag;

  ItemDetail({
    super.key,
    required this.id,
    required this.index,
    required this.heroTag,
  });
  final FavoriteController favController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final homeController = Get.find<HomeController>();
    final cartController = Get.find<CartController>();
    
    final item = _resolveItem(homeController);

    return Scaffold(
      backgroundColor: scheme.surface,
      body: Stack(
        children: [
          _buildHeroSection(context, item, scheme),
          _buildContentCard(context, item, cartController, scheme),
          _buildTopNavigationBar(context, scheme),
        ],
      ),
    );
  }

  // --- UI Sections ---

  Widget _buildHeroSection(
      BuildContext context, dynamic item, ColorScheme scheme) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox.expand(
      child: Stack(
        children: [
          // Ambient glow
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.08,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      scheme.primary.withValues(alpha: isDark ? 0.07 : 0.04),
                      Colors.transparent
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Watch hero image
          Positioned(
            top: 60,
            left: 0,
            right:
                0, // Changed from 56 to 0 to allow the Center widget to take full width
            bottom: MediaQuery.sizeOf(context).height * 0.56,
            child: Center(
              child: ProductHeroImage(
                  heroTag: heroTag, imageUrl: item?.images, images: const []),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentCard(BuildContext context, dynamic item,
      CartController cart, ColorScheme scheme) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      top: MediaQuery.sizeOf(context).height * 0.44,
      child: Container(
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLow,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          border: Border.all(color: scheme.surfaceContainerHighest),
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item?.name ?? 'Product Name',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: scheme.onSurface)),
                    Text('US ${item?.displayPrice ?? r'$0'}',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: scheme.secondary)),
                    const SizedBox(height: 16),
                    Divider(color: scheme.surfaceContainerHighest),
                    const SizedBox(height: 16),
                    Text(item?.description ?? 'No description available.',
                        style: TextStyle(
                            color: scheme.onSurfaceVariant, height: 1.6)),
                    const SizedBox(height: 20),
                    const ProductFeaturesList(),
                  ],
                ),
              ),
            ),
            _buildActionBar(item, cart, scheme),
          ],
        ),
      ),
    );
  }
Widget _buildActionBar(
    dynamic item, CartController cart, ColorScheme scheme) {
  // Use the class-level id and index to create the unique key
  final String productId = '${id}_$index';

  return Container(
    padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
    decoration: BoxDecoration(
      color: scheme.surfaceContainerLow,
      border: Border(top: BorderSide(color: scheme.surfaceContainerHighest)),
    ),
    child: Row(
      children: [
        // Reactive favorite button
        Obx(() {
          final isFav = favController.isFavorite(productId);
          return _iconButton(
            isFav ? Icons.favorite : Icons.favorite_border_outlined,
            scheme,
            () {
              // Toggle logic
              favController.toggleFavorite(productId, item);
              
              // Snackbar logic - notify user
              Get.closeAllSnackbars(); // Close previous ones to avoid stacking
              Get.snackbar(
                "Favorites",
                isFav ? "Removed from favorites" : "Added to favorites",
                snackPosition: SnackPosition.TOP,
                backgroundColor: isFav ? scheme.error : scheme.primary,
                colorText: scheme.onPrimary,
                duration: const Duration(milliseconds: 1000),
                margin: const EdgeInsets.all(16),
                borderRadius: 14,
              );
            },
            iconColor: isFav ? Colors.red : scheme.onSurface,
          );
        }),
        const SizedBox(width: 14),
        Expanded(
          child: _primaryButton(
            'ADD TO CART',
            () => item != null ? _handleAddToCart(cart, item, scheme) : null,
            scheme,
          ),
        ),
      ],
    ),
  );
}
  Widget _buildTopNavigationBar(BuildContext context, ColorScheme scheme) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Align(
            alignment: Alignment.centerLeft,
            child: _iconButton(
              Icons.arrow_back_ios_new,
              scheme,
              () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  // Ensure this helper method looks exactly like this:
Widget _iconButton(
  IconData icon, 
  ColorScheme scheme, 
  VoidCallback onTap, {
  Color? iconColor, // <--- This parameter must be here
}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(13),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: scheme.onSurface.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
        alignment: Alignment.center,
        child: Icon(
          icon, 
          color: iconColor ?? scheme.onSurface, // Uses the passed color
          size: 20,
        ),
      ),
    ),
  );
}

  Widget _primaryButton(String label, VoidCallback? onTap, ColorScheme scheme) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: scheme.primary,
          borderRadius: BorderRadius.circular(14),
        ),
        alignment: Alignment.center,
        child: Text(label,
            style: TextStyle(
                color: scheme.onPrimary,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1)),
      ),
    );
  }

  // --- Logic ---

  dynamic _resolveItem(HomeController controller) {
    final data = controller.homeModel.data;
    if (data == null) return null;
    return (id == 0 ? data.popular : data.lates)?.elementAtOrNull(index);
  }

  void _handleAddToCart(CartController cart, dynamic item, ColorScheme scheme) {
    cart.addToCart(
        productId: '${id}_$index',
        name: item.name ?? 'Unknown',
        image: item.images ?? '',
        priceText: item.displayPrice.toString(),
        qty: 1);
    Get.snackbar(
      'Cart Updated',
      '${item.name ?? 'Item'} added successfully.',
      backgroundColor: scheme.primary,
      colorText: scheme.onPrimary,
    );
  }
}
