class CartItem {
  final String id; // unique per cart line
  final String productId; // underlying product identifier
  final String name;
  final String image;
  final String priceText; // keep as text from API/model (e.g. "$99")
  final int qty;

  const CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.image,
    required this.priceText,
    required this.qty,
  });

  CartItem copyWith({
    String? id,
    String? productId,
    String? name,
    String? image,
    String? priceText,
    int? qty,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      image: image ?? this.image,
      priceText: priceText ?? this.priceText,
      qty: qty ?? this.qty,
    );
  }
}

