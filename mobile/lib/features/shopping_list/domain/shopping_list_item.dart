class ShoppingListItem {
  const ShoppingListItem({
    required this.productId,
    required this.name,
    required this.packaging,
    required this.quantity,
  });

  final String productId;
  final String name;
  final String packaging;
  final int quantity;

  ShoppingListItem copyWith({int? quantity}) {
    return ShoppingListItem(
      productId: productId,
      name: name,
      packaging: packaging,
      quantity: quantity ?? this.quantity,
    );
  }
}
