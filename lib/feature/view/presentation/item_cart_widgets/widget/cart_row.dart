import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_projects_getx/feature/model/cart_item.dart';
import 'qty_button.dart';
import 'qty_pill.dart';

class CartRow extends StatelessWidget {
  final CartItem item;
  final VoidCallback onInc;
  final VoidCallback onDec;
  final VoidCallback onRemove;
  final Function(CartItem) onUndo;

  const CartRow({
    super.key,
    required this.item,
    required this.onInc,
    required this.onDec,
    required this.onRemove,
    required this.onUndo,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Dismissible(
      key: ValueKey(item.productId),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        // 1. Remove the item
        onRemove();

        // 2. Show the Undo action
        Get.snackbar(
          "Removed",
          "${item.name} removed",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: scheme.surfaceContainer,
          colorText: scheme.onSurface,
          duration: const Duration(seconds: 3),
          mainButton: TextButton(
            onPressed: () {
              // 3. Trigger the Undo logic
              onUndo(item);
              if (Get.isSnackbarOpen) Get.close(1);
            },
            child: const Text("UNDO"),
          ),
        );
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: scheme.error,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(20),
          border:
              Border.all(color: scheme.outlineVariant.withValues(alpha: 0.5)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(item.image,
                  width: 70, height: 70, fit: BoxFit.cover),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      QtyButton(
                          icon: Icons.remove, onTap: onDec, scheme: scheme),
                      QtyPill(qty: item.qty, scheme: scheme),
                      QtyButton(icon: Icons.add, onTap: onInc, scheme: scheme),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
