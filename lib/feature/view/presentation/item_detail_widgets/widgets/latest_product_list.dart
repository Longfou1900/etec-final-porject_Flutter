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
    return Column(
      children: List.generate(products?.length ?? 0, (index) {
        final item = products?[index];
        final price = item?.displayPrice ?? r'$0';

        return GestureDetector(
          onTap: () {
            Get.to(
              () =>
                  ItemDetail(id: 1, index: index, heroTag: 'product_1_$index'),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                Hero(
                  tag: 'product_1_$index',
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      bottomLeft: Radius.circular(24),
                    ),
                    child: Image.network(
                      item?.images ?? '',
                      width: 130,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item?.name ?? 'Unknown',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Minimal, comfortable, and designed for everyday wear.',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 13,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 14),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFE7F0FF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 14,
                                    color: Color(0xFF2563EB),
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    '4.8',
                                    style: TextStyle(
                                      color: Color(0xFF2563EB),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Text(
                              price,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
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
