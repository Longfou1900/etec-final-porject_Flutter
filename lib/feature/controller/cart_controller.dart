import 'package:flutter_projects_getx/feature/model/cart_item.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final RxList<CartItem> items = <CartItem>[].obs;

  bool get isEmpty => items.isEmpty;

  /// Helper to store removed item info for Undo functionality
  CartItem? _lastRemovedItem;
  int? _lastRemovedIndex;

  void addToCart({
    required String productId,
    required String name,
    required String image,
    required String priceText,
    int qty = 1,
  }) {
    final index = items.indexWhere((e) => e.productId == productId);
    if (index == -1) {
      items.add(
        CartItem(
          id: '${productId}_${DateTime.now().microsecondsSinceEpoch}',
          productId: productId,
          name: name,
          image: image,
          priceText: priceText,
          qty: qty,
        ),
      );
      return;
    }

    final current = items[index];
    items[index] = current.copyWith(qty: current.qty + qty);
  }

  void increment(String productId) {
    final index = items.indexWhere((e) => e.productId == productId);
    if (index != -1) {
      final current = items[index];
      items[index] = current.copyWith(qty: current.qty + 1);
    }
  }

  void decrement(String productId) {
    final index = items.indexWhere((e) => e.productId == productId);
    if (index != -1) {
      final current = items[index];
      if (current.qty > 1) {
        items[index] = current.copyWith(qty: current.qty - 1);
      } else {
        remove(productId);
      }
    }
  }

  /// Removes item and saves it for Undo
  void remove(String productId) {
    final index = items.indexWhere((e) => e.productId == productId);
    if (index != -1) {
      _lastRemovedItem = items[index];
      _lastRemovedIndex = index;
      items.removeAt(index);
    }
  }

  /// Restores the last removed item to its original position
  void undoRemove() {
    if (_lastRemovedItem != null && _lastRemovedIndex != null) {
      items.insert(_lastRemovedIndex!, _lastRemovedItem!);
      _lastRemovedItem = null;
      _lastRemovedIndex = null;
    }
  }

  void clear() {
    items.clear();
  }

  double _parsePrice(String priceText) {
    final cleaned = priceText.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0;
  }

  double get totalPrice {
    return items.fold(
        0, (sum, item) => sum + (_parsePrice(item.priceText) * item.qty));
  }

  String get totalPriceText => '\$${totalPrice.toStringAsFixed(2)}';
}
