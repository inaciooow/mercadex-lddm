class SearchDeal {
  const SearchDeal({
    required this.id,
    required this.productName,
    required this.packaging,
    required this.marketName,
    required this.branchName,
    required this.price,
  });

  final String id;
  final String productName;
  final String packaging;
  final String marketName;
  final String branchName;
  final String price;

  factory SearchDeal.fromJson(Map<String, dynamic> json) {
    final product = json['product'] as Map<String, dynamic>;
    final market = json['market'] as Map<String, dynamic>;
    final branch = json['branch'] as Map<String, dynamic>;

    return SearchDeal(
      id: json['id'] as String,
      productName: product['name'] as String,
      packaging: product['packaging'] as String,
      marketName: market['name'] as String,
      branchName: branch['name'] as String,
      price: json['price'] as String,
    );
  }
}
