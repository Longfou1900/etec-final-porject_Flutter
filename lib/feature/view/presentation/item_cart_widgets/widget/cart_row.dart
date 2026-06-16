import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/model/cart_item.dart';
import 'qty_button.dart';
import 'qty_pill.dart';

class CartRow extends StatelessWidget {
  final CartItem item;
  final VoidCallback onInc;
  final VoidCallback onDec;
  final VoidCallback onRemove;

  const CartRow({
    super.key,
    required this.item,
    required this.onInc,
    required this.onDec,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 18,
              offset: const Offset(0, 10),
            )
          ],
        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                item.image,
                width: 66,
                height: 66,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Price: ${item.priceText}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: scheme.onSurface.withValues(alpha: 0.65),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 42,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Row(
                          children: [
                            QtyButton(
                              icon: Icons.remove,
                              onTap: onDec,
                              scheme: scheme,
                            ),
                            QtyPill(qty: item.qty, scheme: scheme),
                            QtyButton(
                              icon: Icons.add,
                              onTap: onInc,
                              scheme: scheme,
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.red.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: onRemove,
                                child: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  item.priceText,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: scheme.onSurface,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'x${item.qty}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: scheme.onSurface.withValues(alpha: 0.55),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}