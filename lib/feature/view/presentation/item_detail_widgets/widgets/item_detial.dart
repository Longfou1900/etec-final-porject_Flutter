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

// Import the sub-widgets
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

  static const primaryColor = Color(0xFF2563EB);
  static const backgroundColor = Color(0xFFF8F9FB);
  static final borderRadiusLarge = BorderRadius.circular(32);
  static final borderRadiusMedium = BorderRadius.circular(18);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final cartController = Get.find<CartController>();
    
    final item = _resolveItem(homeController);
    final price = item?.displayPrice ?? r'$0';
    final collectionName = id == 0 ? 'Popular collection' : 'Latest collection';

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const DetailHeader(),
            ProductHeroImage(heroTag: heroTag, imageUrl: item?.images),
            const SizedBox(height: 24),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: borderRadiusLarge.topLeft,
                    topRight: borderRadiusLarge.topRight,
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductTitleAndPrice(name: item?.name, price: price),
                      const SizedBox(height: 12),
                      ProductRatingTag(collectionName: collectionName),
                      const SizedBox(height: 22),
                      ProductOverview(description: item?.description),
                      const SizedBox(height: 24),
                      const ProductFeaturesList(),
                      const SizedBox(height: 28),
                      ActionButtons(
                        onWishlistPressed: () {},
                        onAddToCartPressed: item == null 
                            ? null 
                            : () => _handleAddToCart(cartController, item),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  dynamic _resolveItem(HomeController controller) {
    final data = controller.homeModel.data;
    if (id == 0) {
      return data?.popular != null && index < data!.popular!.length ? data.popular![index] : null;
    } else {
      return data?.lates != null && index < data!.lates!.length ? data.lates![index] : null;
    }
  }

  void _handleAddToCart(CartController cartController, dynamic item) {
    final productId = '${id}_$index';
    cartController.addToCart(
      productId: productId,
      name: item.name ?? 'Unknown watch',
      image: item.images ?? '',
      priceText: (item.displayPrice).toString(),
      qty: 1,
    );

    Get.snackbar(
      'Added to cart',
      item.name ?? 'Item',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black.withValues(alpha: 0.85),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
      duration: const Duration(seconds: 1),
    );
  }
}