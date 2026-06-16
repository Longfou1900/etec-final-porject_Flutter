import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/modules/controller/cart_controller.dart';
import 'package:flutter_projects_getx/modules/controller/home_controller.dart';
import 'package:get/get.dart';

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
    final controller = Get.find<HomeController>();
    final cartController = Get.find<CartController>();
    final popularItems = controller.homeModel.data?.popular;
    final latestItems = controller.homeModel.data?.lates;

    final item = id == 0
        ? (popularItems != null ? popularItems[index] : null)
        : (latestItems != null ? latestItems[index] : null);
    final price = item?.displayPrice ?? r'$0';

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 14,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 20),
                    ),
                  ),
                  const Text(
                    'Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Container(width: 44),
                ],
              ),
            ),
            Hero(
              tag: heroTag,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.network(
                  item?.images ?? '',
                  height: 320,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item?.name ?? 'Unknown watch',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Text(
                            price,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F1FF),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Color(0xFF2563EB),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '4.9',
                                  style: TextStyle(
                                    color: Color(0xFF2563EB),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            id == 0
                                ? 'Popular collection'
                                : 'Latest collection',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      const Text(
                        'Overview',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        (item != null &&
                                item.description != null &&
                                item.description!.isNotEmpty)
                            ? item.description!
                            : 'A premium watch with a modern silhouette, sharp detailing, and a refined finish built for everyday luxury.',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 15,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Features',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _buildFeatureTile(Icons.watch, 'Stainless steel finish'),
                      const SizedBox(height: 12),
                      _buildFeatureTile(Icons.bolt, 'Automatic movement'),
                      const SizedBox(height: 12),
                      _buildFeatureTile(Icons.water_drop, 'Water resistant'),
                      const SizedBox(height: 28),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(0xFF2563EB),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                              ),
                              child: const Text(
                                'Wishlist',
                                style: TextStyle(
                                  color: Color(0xFF2563EB),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: item == null
                                  ? null
                                  : () {
                                      final productId = '${id}_$index';
                                      cartController.addToCart(
                                        productId: productId,
                                        name: item.name ?? 'Unknown watch',
                                        image: item.images ?? '',
                                        priceText: (item.displayPrice)
                                            .toString(),
                                        qty: 1,
                                      );

                                      Get.snackbar(
                                        'Added to cart',
                                        item.name ?? 'Item',
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.black
                                            .withValues(alpha: 0.85),
                                        colorText: Colors.white,
                                        margin: const EdgeInsets.all(16),
                                        borderRadius: 16,
                                        duration: const Duration(seconds: 1),
                                      );
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2563EB),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                              ),
                              child: const Text(
                                'Add to Cart',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ],
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

  Widget _buildFeatureTile(IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F6FF),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, size: 18, color: const Color(0xFF2563EB)),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
