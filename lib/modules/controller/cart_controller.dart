import 'package:flutter_projects_getx/modules/model/cart_item.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  /// Cart items stored in memory (stateless UI requirement is satisfied).
  final RxList<CartItem> items = <CartItem>[].obs;

  bool get isEmpty => items.isEmpty;

  String _makeProductKey({required String productId}) => productId;

  /// Adds product; if product exists, increments qty.
  void addToCart({
    required String productId,
    required String name,
    required String image,
    required String priceText,
    int qty = 1,
  }) {
    final key = _makeProductKey(productId: productId);

    final index = items.indexWhere((e) => e.productId == key);
    if (index == -1) {
      items.add(
        CartItem(
          id: '${key}_${DateTime.now().microsecondsSinceEpoch}',
          productId: key,
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
    final key = _makeProductKey(productId: productId);
    final index = items.indexWhere((e) => e.productId == key);
    if (index == -1) return;
    final current = items[index];
    items[index] = current.copyWith(qty: current.qty + 1);
  }

  void decrement(String productId) {
    final key = _makeProductKey(productId: productId);
    final index = items.indexWhere((e) => e.productId == key);
    if (index == -1) return;
    final current = items[index];
    final newQty = current.qty - 1;
    if (newQty <= 0) {
      items.removeAt(index);
    } else {
      items[index] = current.copyWith(qty: newQty);
    }
  }

  void remove(String productId) {
    final key = _makeProductKey(productId: productId);
    items.removeWhere((e) => e.productId == key);
  }

  void clear() {
    items.clear();
  }

  double _parsePrice(String priceText) {
    // Examples: "$199", "$0", "199"
    final cleaned = priceText.replaceAll(RegExp(r'[^0-9.]'), '');
    if (cleaned.isEmpty) return 0;
    return double.tryParse(cleaned) ?? 0;
  }

  double get totalPrice {
    double sum = 0;
    for (final e in items) {
      sum += _parsePrice(e.priceText) * e.qty;
    }
    return sum;
  }

  String get totalPriceText => '\$${totalPrice.toStringAsFixed(2)}';
}

